class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps
  has_many :plus_ones, through: :rsvps

  validates :name, uniqueness: true, case_sensitive: false

  GOOGLE_MAP_BASE_URL='https://www.google.com/maps/place/'

  def timespan
    return unless formatted_start_time && formatted_end_time

    if slug == 'save-the-date' # special case
      "#{formatted_start_date}-#{formatted_end_date}"
    else
      "#{formatted_start_date}, #{formatted_start_time}-#{formatted_end_time}"
    end
  end

  def formatted_start_time
    return if start_time.nil?
    start_time.strftime("%l:%M").strip
  end

  def formatted_end_time
    return if end_time.nil?
    end_time.strftime("%l:%M%P").strip
  end

  def formatted_start_date
    return if start_time.nil?
    start_time.strftime("%B %e").strip
  end

  def formatted_end_date
    return if end_time.nil?
    end_time.strftime("%e").strip
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
