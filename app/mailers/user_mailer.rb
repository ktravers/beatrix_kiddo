class UserMailer < ApplicationMailer

  # special case invite
  def send_save_the_date(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = formatted_recipient(user)
    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "#{event.name.upcase} for KC and Kate [Labor Day Weekend, #{event.timespan}, #{event.year}]"

    send_email(recipient, @subject)
    rsvp.sent!
  end

  # generic event invite
  def send_invite(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    plus_one         = rsvp.plus_one
    recipient        = formatted_recipient(user)

    @has_plus_one    = plus_one
    @event_slug      = event.slug
    @event_name      = event.name
    @event_venue     = event.venue_name
    @event_address   = event.venue_address
    @event_date      = "#{event.formatted_start_date}, #{event.year}"
    @event_time      = "#{event.formatted_start_time}-#{event.formatted_end_time}"
    @event_name_with_article = indefinite_article(event.name)

    @rsvp_url        = "http://www.kcandkate.us/events/#{@event_slug}#rsvp"
    @gcal_url        = event.gcal_url
    @venue_map_url   = event.venue_map_url

    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "[Invitation] #{@event_name.upcase} for KC and Kate: #{@event_date}"

    send_email(recipient, @subject)
    rsvp.sent!
  end

  # non-event specific announcement
  def send_announcement(email)
    user = User.find_by_email(email)
    recipient        = formatted_recipient(user)

    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "[Reminder] Travel Plans for KC and Kate's Wedding"

    send_email(recipient, @subject)
  end

  private

  def formatted_recipient(user)
    %("#{user.full_name}" <#{user.email}>)
  end

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
