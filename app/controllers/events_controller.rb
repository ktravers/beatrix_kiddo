class EventsController < ApplicationController
  include EventHelper

  def show
    event = Event.find_by(slug: params[:event_slug])
    graceful_redirect(no_event_message) and return unless event

    @event_slug = event.slug
    @event_name = event.name
    login_required(redirect_path: "/events/#{@event_slug}") and return unless current_user

    @rsvp = Rsvp.find_by(user: current_user, event: event)
    graceful_redirect(no_rsvp_message) and return unless @rsvp

    @event_venue    = event.venue_name
    @event_address  = event.venue_address
    @event_timespan = event.timespan
    @event_year     = event.year
    @event_map_url  = event.venue_map_url
    @event_gcal_url = event.gcal_url

    # TODO
    # @event_background_image = "#{event.name.parameterize}.gif"

    respond_to do |f|
      f.html
      f.ics do
        send_data event.to_ical, filename: "kc-and-kate-#{event.slug}.ics"
      end
    end
  end

  private

  def event_params
    params.permit(:event_slug)
  end

  def no_event_message
    "Couldn't find a page for that event, but don't worry, prolly "\
    "just a typo. Check the url and try again."
  end

  def no_rsvp_message
    "Couldn't find your invite for the #{@event_name.downcase}. Please email "\
    "<a href='mailto:rsvp@kcandkate.us'>rsvp@kcandkate.us</a> for tech support."
  end
end
