class RsvpMailer < ApplicationMailer

  def send_confirmation(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = %("#{user.full_name}" <#{user.email}>)

    @rsvp_status     = rsvp.status
    @attending       = rsvp.accepted_at

    @event_slug      = event.slug
    @event_name      = event.name
    @event_venue     = event.venue_name
    @event_address   = event.venue_address
    @event_date      = "#{event.formatted_start_date}, #{event.year}"
    @event_time      = "#{event.formatted_start_time}-#{event.formatted_end_time}"

    @rsvp_url        = "http://www.kcandkate.us/events/#{@event_slug}#rsvp"
    @gcal_url        = event.gcal_url
    @venue_map_url   = event.venue_map_url

    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "[RSVP: #{@rsvp_status}] #{@event_name} for KC and Kate: #{@event_date}"

    sendgrid_category :use_subject_lines

    mail(
      to: recipient,
      subject: @subject,
      content_type: 'text/html'
    )
  end
end
