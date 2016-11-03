class EventsController < ApplicationController
  include EventHelper

  before_action :authorize_event

  def show
    @rsvp = Rsvp.find_by(user: current_user, event: @event)
    graceful_redirect(no_rsvp_message) and return unless @rsvp

    @event_name     = @event.name
    @event_slug     = @event.slug
    @event_venue    = @event.venue_name
    @event_address  = @event.venue_address
    @event_timespan = @event.timespan
    @event_year     = @event.year
    @event_map_url  = @event.venue_map_url
    @event_gcal_url = @event.gcal_url
    @plus_one       = @rsvp.plus_one

    # TODO
    # @event_background_image = "#{event.name.parameterize}.gif"

    respond_to do |f|
      f.html
      f.ics do
        send_data event.to_ical, filename: "kc-and-kate-#{@event_slug}.ics"
      end
    end
  end

  def dashboard
    graceful_redirect('Admins only.') and return unless current_user.admin?

    rsvps     = @event.rsvps
    plus_ones = @event.plus_ones
    @rsvps    = (rsvps + plus_ones).sort_by { |r| r.status }

    @attending_count     = (rsvps.attending + plus_ones.attending).count
    @not_attending_count = (rsvps.not_attending + plus_ones.not_attending).count
    @unconfirmed_count   = (rsvps.unconfirmed + plus_ones.unconfirmed).count

    # TODO
    # download to csv
  end

  private

  def authorize_event
    @event = Event.find_by(slug: event_params[:event_slug])
    graceful_redirect(no_event_message) and return unless @event

    login_required(redirect_path: "/events/#{event_params[:event_slug]}") and return unless current_user
  end

  def event_params
    params.permit(:event_slug)
  end

  def no_event_message
    "Couldn't find a page for that event, but don't worry, prolly "\
    "just a typo. Check the url and try again."
  end

  def no_rsvp_message
    "Couldn't find your invite for the #{@event.name.downcase}. Please email "\
    "<a href='mailto:rsvp@kcandkate.us'>rsvp@kcandkate.us</a> for tech support."
  end
end
