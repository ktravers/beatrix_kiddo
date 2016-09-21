class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: %("KC and Kate" <rsvp@kcandkate.us>)
  default reply_to: 'rsvp@kcandkate.us, kate@kcandkate.us, kc@kcandkate.us'
  layout 'mailer'
end
