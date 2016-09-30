class RsvpMailer < ApplicationMailer

  def send_confirmation(rsvp)
    user             = rsvp.user
    event            = rsvp.event
    recipient        = %("#{user.full_name}" <#{user.email}>)
    @user_email      = user.email
    @user_first_name = user.first_name
    @subject         = "#{event.name.upcase} for KC and Kate [Labor Day Weekend, #{event.timespan}, #{event.year}]"

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
end
