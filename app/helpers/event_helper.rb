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

  def can_confirm_plus_one
    @rsvp.unconfirmed_plus_one?
  end

  def can_update_plus_one
    @rsvp.attending? && @rsvp.confirmed_plus_one?
  end

end
