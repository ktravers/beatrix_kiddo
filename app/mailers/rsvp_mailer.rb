class RsvpMailer < ApplicationMailer

  def send_confirmation(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = %("#{user.full_name}" <#{user.email}>)
    @rsvp_status     = rsvp.status
    @event_name      = event.name
    @event_venue     = event.venue_name
    @event_address   = event.venue_address
    @event_timespan  = "#{event.timespan}, #{event.year}"
    @event_date      = "#{event.formatted_start_date}, #{event.year}"
    @event_time      = "#{event.formatted_start_time}-#{event.formatted_end_time}"
    @attending       = rsvp.accepted_at
    @rsvp_url        = "http://www.kcandkate.us/events/#{event.slug}#rsvp"
    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "[RSVP: #{@rsvp_status}] #{@event_name} for KC and Kate: #{@event_time}"

    sendgrid_category :use_subject_lines

    mail(
      to: recipient,
      subject: @subject,
      content_type: 'text/html'
    )
  end
end
