class EventsController < ApplicationController
  # TODO: check user event permissions and redirect

  def show
    @event = Event.find_by(slug: params[:event_slug])

    if @event
      @event_name     = @event.name
      @event_venue    = @event.venue_name
      @event_address  = @event.venue_address
      @event_timespan = build_event_timespan
      @event_year     = @event.start_time.strftime('%Y')
      @event_map_url  = @event.venue_map_url
    else
      flash[:error] = 'Couldn\'t find a page for that event, but don\'t worry; prolly just a typo. Check the url and try again.'
      redirect_to root_path
    end
  end

  private

  def event_params
    params.permit(:event_slug)
  end

  def build_event_timespan
    if @event.slug == 'save-the-date' # special case
      start_date = @event.start_time.strftime("%B %e").strip
      end_date = @event.end_time.strftime("%e").strip
      "#{start_date}-#{end_date}"
    else
      event_date = @event.start_time.strftime("%B %e")
      start_time = @event.start_time.strftime("%l:%M")
      end_time   = @event.end_time.strftime("%l:%M%P")
      "#{event_date}, #{start_time}-#{end_time}"
    end
  end
end
