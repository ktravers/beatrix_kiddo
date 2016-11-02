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
    @rsvp.unconfirmed?
  end

  def rsvp_confirmed
    @rsvp.confirmed?
  end

  def can_confirm_rsvp_and_plus_one
    @rsvp.unconfirmed? && @rsvp.unconfirmed_plus_one?
  end

  def can_confirm_plus_one
    @rsvp.attending? && @rsvp.unconfirmed_plus_one?
  end

  def can_update_plus_one
    @rsvp.attending? && @rsvp.confirmed_plus_one?
  end

end
