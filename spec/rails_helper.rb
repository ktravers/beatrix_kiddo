ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'

# allowed_hosts = []
# allowed_hosts << Regexp.new(ENV['NGINX_IP']) if ENV['NGINX_IP']
# WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_hosts)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.default_cassette_options = {
    record: :once,
    match_requests_on: [:host, :path, :query]
  }

  c.register_request_matcher :uri_ignoring_trailing_email do |rq1, rq2|
    uri1, uri2 = rq1.uri, rq2.uri
    regexp_trail_email = %r(/[0-9a-zA-Z@+.\-\_\&\%]+\z)
    if uri1.match(regexp_trail_email)
      uri1_without_email = uri1.gsub(regexp_trail_email, '')
      uri2_without_email = uri2.gsub(regexp_trail_email, '')
      uri1.match(regexp_trail_email) && uri2.match(regexp_trail_email) && uri1_without_email == uri2_without_email
    else
      uri1 == uri2
    end
  end
end

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.infer_spec_type_from_file_location!

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:each, js: true) do
    Capybara.page.driver.browser.manage.window.resize_to(1024, 768)
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
