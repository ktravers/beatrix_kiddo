class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: %("Kate and KC" <rsvp@kcandkate.us>)
  default reply_to: 'rsvp@kcandkate.us, kate@kcandkate.us, kc@kcandkate.us'
  layout 'mailer'
end
