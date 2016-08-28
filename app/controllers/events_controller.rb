class EventsController < ApplicationController

  def show
    event = Event.find_by(slug: params[:event_slug])

    if event
      @event_slug = event.slug
      login_required(redirect_path: "/events/#{@event_slug}") and return if !current_user
      redirect_uninvited(event) and return

      @event_name     = event.name
      @event_venue    = event.venue_name
      @event_address  = event.venue_address
      @event_timespan = build_event_timespan(event)
      @event_year     = event.start_time.strftime('%Y')
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
    else
      flash[:error] = 'Couldn\'t find a page for that event, but don\'t worry; prolly just a typo. Check the url and try again.'
      redirect_to root_path
    end
  end

  private

  def event_params
    params.permit(:event_slug)
  end

  def build_event_timespan(event)
    if event.slug == 'save-the-date' # special case
      start_date = event.start_time.strftime("%B %e").strip
      end_date = event.end_time.strftime("%e").strip
      "#{start_date}-#{end_date}"
    else
      event_date = event.start_time.strftime("%B %e").strip
      start_time = event.start_time.strftime("%l:%M").strip
      end_time   = event.end_time.strftime("%l:%M%P").strip
      "#{event_date}, #{start_time}-#{end_time}"
    end
  end

  def redirect_uninvited(event)
    unless current_user.invited_to?(event.id)
      return redirect_to root_path
    end
  end
end
