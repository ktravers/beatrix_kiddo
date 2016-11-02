class RsvpPreview < ActionMailer::Preview

  def send_confirmation
    RsvpMailer.send_confirmation(Rsvp.attending.last)
  end

  def send_reminder
    RsvpMailer.send_reminder(Rsvp.unconfirmed.last)
  end
end
