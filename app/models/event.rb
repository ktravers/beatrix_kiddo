class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps

  validates :name, uniqueness: true, case_sensitive: false

  GOOGLE_MAP_BASE_URL='https://www.google.com/maps/place/'

  def timespan
    return if start_time.nil? || end_time.nil?

    if slug == 'save-the-date' # special case
      formatted_start = start_time.strftime("%B %e").strip
      formatted_end = end_time.strftime("%e").strip
      "#{formatted_start}-#{formatted_end}"
    else
      formatted_date  = start_time.strftime("%B %e").strip
      formatted_start = start_time.strftime("%l:%M").strip
      formatted_end   = end_time.strftime("%l:%M%P").strip
      "#{formatted_date}, #{formatted_start}-#{formatted_end}"
    end
  end

  def year
    return if start_time.nil?
    start_time.strftime('%Y')
  end

  def venue_map_url
    # https://www.google.com/maps/place/Dumbo,+Brooklyn,+NY
    "#{GOOGLE_MAP_BASE_URL}#{venue_address.split(' ').join('+')}"
  end

  def gcal_url
    return if start_time.nil? || end_time.nil?

    Google::CalendarEventGenerator.event_url(
      start_at: start_time,
      finish_at: end_time,
      name: "KC and Kate's Wedding: #{self.name}",
      description: "KC and Kate's Wedding: #{self.name}\n#{self.venue_name}\n#{self.venue_address}"
    )
  end

  def to_ical
    to_ics.to_ical
  end

  def to_ics
    return if start_time.nil? || end_time.nil?

    IcsGenerator.new.add_event(
      start_at: start_time,
      finish_at: end_time,
      summary: "KC and Kate's Wedding: #{self.name}",
      description: "KC and Kate's  Wedding: #{self.name}\n#{self.venue_name}\n#{self.venue_address}",
      url: "#{self.venue_map_url}"
    )
  end
end
