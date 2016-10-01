class UserMailer < ApplicationMailer

  # special case invite
  def send_save_the_date(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = %("#{user.full_name}" <#{user.email}>)
    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "#{event.name.upcase} for KC and Kate [Labor Day Weekend, #{event.timespan}, #{event.year}]"

    send_email(recipient, @subject)
  end

  # generic event invite
  def send_invite(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = %("#{user.full_name}" <#{user.email}>)

    @event_slug      = event.slug
    @event_name      = event.name
    @event_venue     = event.venue_name
    @event_address   = event.venue_address
    @event_timespan  = "#{event.timespan}, #{event.year}"
    @event_date      = "#{event.formatted_start_date}, #{event.year}"
    @event_time      = "#{event.formatted_start_time}-#{event.formatted_end_time}"
    @event_name_with_article = indefinite_article(event.name)

    @rsvp_url        = "http://www.kcandkate.us/events/#{@event_slug}#rsvp"
    @gcal_url        = event.gcal_url
    @venue_map_url   = event.venue_map_url

    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "#{@event_name.upcase} for KC and Kate [#{@event_time}]"

    send_email(recipient, @subject)
  end

  private

  def send_email(recipient, subject)
    sendgrid_category :use_subject_lines

    mail(
      to: recipient,
      subject: subject,
      content_type: 'text/html'
    )
  end

  # http://stackoverflow.com/a/5381922/3880374
  def indefinite_article(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end
end
