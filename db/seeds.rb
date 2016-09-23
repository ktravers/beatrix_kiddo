require 'csv'

# Populate events table

event_names = [
  'Save The Date',
  'Engagement Party',
  'Bachelorette Party',
  'Bachelor Party',
  'Rehearsal Dinner',
  'Ceremony',
  'Reception',
  'After Party'
]

event_names.each do |event_name|
  env_event = event_name.split(' ').join('_').upcase

  Event.create({
    name: event_name,
    slug: event_name.parameterize,
    venue_name: ENV["#{env_event}_VENUE_NAME"],
    venue_address: ENV["#{env_event}_VENUE_ADDRESS"],
    start_time: Time.zone.parse(ENV["#{env_event}_START_TIME"]),
    end_time: Time.zone.parse(ENV["#{env_event}_END_TIME"])
  })
end

# Populate users and user_events tables
#
# Include CSV file 'invites.csv' at root level of project directory
# CSV columns should be organized as follows with events in order left to right from first to last:
#
# First name | Last name | Email              | Save The Date | Engagement Party | etc...
# ---------------------------------------------------------------------------------------
# Beatrix    | Kiddo     | bride@thebride.com | yes           | yes              | yes
#
# Note: current setup is very rigid and dependent on cleanly formatted data.
# Refactor to be more flexible.

CSV.foreach('invites.csv', headers: true) do |row|
  # row => ['Beatrix', 'Kiddo', 'bride@thebride.com', 'yes', 'yes' etc...]

  user = User.find_or_create_by(
    first_name: row[0],
    last_name: row[1],
    email: row[2]
  )

  affirmative_responses = ['yes', 'y', 'true', 't', '1']

  row[3..-1].each.with_index(1) do |cell, index|
    if cell && affirmative_responses.include?(cell.downcase)
      Rsvp.find_or_create_by(
        user_id: user.id,
        event_id: index
      )
    end
  end
end
