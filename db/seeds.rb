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
