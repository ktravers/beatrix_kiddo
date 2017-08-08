class RsvpPreview < ActionMailer::Preview

  def send_confirmation
    RsvpMailer.send_confirmation(Rsvp.attending.last)
  end

  def send_reminder_attending
    RsvpMailer.send_reminder(Rsvp.where(event_id: 6).attending.last)
  end

  def send_reminder_unconfirmed
    RsvpMailer.send_reminder(Rsvp.where(event_id: 6).unconfirmed.last)
  end
end
