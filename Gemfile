ruby '2.3.1'
source 'https://rubygems.org'

# Load environment variables in development
gem 'dotenv-rails', '>= 2.1.0'

# Frameworks
gem 'rails', '4.2.5'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# HTTP client
gem 'faraday', '0.9.1'
gem 'faraday_middleware', '0.9.1'

# API Wrappers
gem 'icalendar', '>= 2.3.0'

# Assets - Stylesheets
gem 'sass-rails', '~> 5.0'

# Assets - JavaScript
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

# Templating
gem 'slim', '>= 3.0.6'

# Build JSON APIs. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
  gem 'selenium-webdriver', '>= 2.52.0'
end

group :development do
  gem 'better_errors', '2.1.1'
  gem 'active_record_query_trace', '1.4'
  gem 'letter_opener_web', '~> 1.2.0'
end

group :test do
  gem 'capybara', '>= 2.4.4'
  gem 'database_cleaner', '>= 1.4.1'
  gem 'email_spec', '>= 1.6.0'
  gem 'factory_girl_rails', '>= 4.5.0'
  gem 'faker', '>= 1.4.3'
  gem 'shoulda-matchers', '>= 2.7.0'
  gem 'timecop', '>= 0.7.1'
  gem 'vcr', '>= 2.9.3'
  gem 'webmock', '>= 1.20.4'
  gem 'rspec_junit_formatter', '>= 0.2.2'
end
