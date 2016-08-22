class Event < ActiveRecord::Base
  has_many :users, through: :rsvps

  validates :name, uniqueness: true

  def venue_map_url
    # https://www.google.com/maps/place/Dumbo,+Brooklyn,+NY
    "https://www.google.com/maps/place/#{venue_address.split(' ').join('+')}"
  end

  def gcal_url
    Google::CalendarEventGenerator.event_url(
      start_at: start_time,
      finish_at: end_time,
      name: "KC and Kate's #{self.name}",
      description: "KC and Kate's #{self.name}\n#{self.venue_name}\n#{self.venue_address}"
    )
  end

  def to_ical
    to_ics.to_ical
  end

  def to_ics
    IcsGenerator.new.add_event(
      start_at: start_time,
      finish_at: end_time,
      summary: "KC and Kate's #{self.name}",
      description: "KC and Kate's #{self.name}\n#{self.venue_name}\n#{self.venue_address}",
      url: "#{self.venue_map_url}"
    )
  end
end
