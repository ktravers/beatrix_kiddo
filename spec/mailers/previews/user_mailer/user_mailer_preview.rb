class UserMailerPreview < ActionMailer::Preview
  def deliver_reset_password
    user = User.last
    reset_password = 'test'
    UserMailerMailer.deliver_reset_password(user, reset_password)
  end
end
