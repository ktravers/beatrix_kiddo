class UserMailer < ApplicationMailer

  # special case invite
  def send_save_the_date(rsvp)
    user = rsvp.user
    event = rsvp.event
    recipient = user.email
    @user_name = user.full_name
    @subject = "KC and Kate Invite You to #{event.name.upcase} [Labor Day Weekend, #{event.timespan}, #{event.year}]"

    send_email(recipient, @subject)
  end

  # generic event invite
  def send_invite(rsvp)
    user = rsvp.user
    event = rsvp.event
    recipient = user.email
    @user_name = user.full_name
    @subject = "KC and Kate Invite You to #{event.name.upcase} [#{event.timespan}]"

    send_email(recipient, @subject)
  end

  private

  def send_email(recipient, subject)
    mail(
      to: recipient,
      subject: subject,
      content_type: 'text/html'
    )
  end
end
