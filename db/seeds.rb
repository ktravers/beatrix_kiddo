events = [
  'Engagement Party',
  'Bachelorette Party',
  'Bachelor Party',
  'Rehearsal Dinner',
  'Ceremony',
  'Reception',
  'After Party'
]

events.each do |event|
  env_event = event.split(' ').join('_').upcase

  Event.create({
    name: event,
    venue_name: ENV["#{env_event}_VENUE_NAME"],
    venue_address: ENV["#{env_event}_VENUE_ADDRESS"],
    start_time: Time.zone.parse(ENV["#{env_event}_START_TIME"]),
    end_time: Time.zone.parse(ENV["#{env_event}_END_TIME"])
  })
end
