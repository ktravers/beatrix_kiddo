FactoryGirl.define do
  factory :event do
    name { Faker::Lorem.word }
    venue_name { Faker::Company.name }
    venue_address { "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}" }
    slug { Faker::Address.city }
    start_time { Faker::Time.forward(30, :morning) }
    end_time { Faker::Time.forward(30, :evening) }
  end
end
