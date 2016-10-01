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
  env_event     = event_name.split(' ').join('_').upcase
  slug          = event_name.parameterize
  venue_name    = ENV["#{env_event}_VENUE_NAME"] || 'venue tbd'
  venue_address = ENV["#{env_event}_VENUE_ADDRESS"]
  start_time    = Time.zone.parse(ENV["#{env_event}_START_TIME"])
  end_time      = Time.zone.parse(ENV["#{env_event}_END_TIME"])

  Event.find_or_create_by({
    name: event_name,
    slug: slug,
    venue_name: venue_name,
    venue_address: venue_address,
    start_time: start_time,
    end_time: end_time
  })
end

# Populate users and rsvp tables
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

  first_name = row[0].strip.titleize unless row[0].blank?
  last_name  = row[1].strip.titleize unless row[1].blank?
  email      = row[2].strip.downcase unless row[2].blank?
  full_name  = "#{first_name} #{last_name}"

  puts "Creating user: #{full_name}...\n"
  user = User.create(
    first_name: first_name,
    last_name: last_name,
    email: email
  )

  if user.valid?
    puts "Created account: id##{user.id}\n"
  else
    puts "Error creating account for #{full_name}\n"
  end

  affirmative_responses = ['yes', 'y', 'true', 't', '1']
  rsvp_count = 0

  puts "Creating rsvps for #{full_name}..."
  row[3..-1].each.with_index(1) do |cell, index|
    if cell && affirmative_responses.include?(cell.downcase)
      rsvp = Rsvp.create(
        user_id: user.id,
        event_id: index
      )

      if rsvp.valid?
        rsvp_count += 1
      end
    end
  end

  puts "Created #{rsvp_count} rsvps for #{full_name}.\n\n"
end
