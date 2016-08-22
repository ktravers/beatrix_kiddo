class IcsGenerator
  require 'icalendar/tzinfo'
  include Icalendar

  attr_reader :cal, :tzid

  def initialize
    @cal = Calendar.new
    @tzid = Time.zone.tzinfo.name
    configure_timezone
  end

  def add_event(start_at:, finish_at:, summary:, description:, url:nil)
    cal.event do |e|
      e.dtstart = Values::DateTime.new(start_at, 'tzid' => tzid)
      e.dtend   = Values::DateTime.new(finish_at, 'tzid' => tzid)
      e.summary = summary
      e.description = description
      e.url = url
    end

    cal.publish
    cal
  end

  private

  def configure_timezone
    timezone = Time.zone.tzinfo.ical_timezone(Time.now)
    cal.add_timezone(timezone)
  end
end
