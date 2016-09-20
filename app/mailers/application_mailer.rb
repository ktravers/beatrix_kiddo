class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: 'rsvp@kcandkate.us'
  default reply_to: 'rsvp@kcandkate.us, kate@kcandkate.us, kc@kcandkate.us'
  layout 'mailer'
end
