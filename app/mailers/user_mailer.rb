class UserMailer < ApplicationMailer
  def deliver_reset_password(user, reset_password)
    @reset_password = reset_password
    @user_name = user.full_name
    recipient = user.email
    subject = 'Reset Password: kcandkate.us'

    mail(
      to: recipient,
      subject: subject,
      reply_to: 'kate@kcandkate.us, kc@kcandkate.us',
      content_type: 'text/html',
    )
  end
end
