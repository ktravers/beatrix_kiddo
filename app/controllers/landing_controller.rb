class LandingController < ApplicationController

  def show
    first_event = Event.find_by(name: 'Rehearsal Dinner')
    last_event = Event.find_by(name: 'Ceremony')
    start_date = first_event.start_time.strftime('%B %e')
    end_date = last_event.end_time.strftime('%e')
    @event_date_range = "#{start_date} - #{end_date}"
    @event_year = first_event.start_time.strftime('%Y')
  end
end
