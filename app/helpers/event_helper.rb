module EventHelper
  def event_booked
    !@event_venue.include?('tbd')
  end
end
