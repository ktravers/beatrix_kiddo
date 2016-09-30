class RsvpPreview < ActionMailer::Preview

  def send_confirmation
    RsvpMailer.send_confirmation(Rsvp.attending.last)
  end
end
