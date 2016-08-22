module Google
  class CalendarEventGenerator
    class << self
      def event_url(start_at:, finish_at:, name:, description:'')
        start_time = start_at.utc.strftime('%Y%m%dT%H%M00Z')
        finish_time = finish_at.utc.strftime('%Y%m%dT%H%M00Z')

        URI.encode("https://www.google.com/calendar/render?action=TEMPLATE&text=#{name}&dates=#{start_time}/#{finish_time}&details=#{description}&sf=true&output=xml")
      end
    end
  end
end
