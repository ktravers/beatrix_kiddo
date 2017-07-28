class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: %("KC and Kate" <rsvp@kcandkate.us>)
  default reply_to: 'rsvp@kcandkate.us, kate@kcandkate.us, kc@kcandkate.us'
  layout 'mailer'

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
end
