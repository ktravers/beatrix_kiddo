module EventHelper
  def event_booked
    !@event_venue.include?('tbd')
  end

  def rsvp_required
    # special cases
    @event_slug != 'after-party' &&
      @event_slug != 'save-the-date'
  end

  def rsvp_unconfirmed
    @rsvp.accepted_at.blank? && @rsvp.declined_at.blank?
  end
end
