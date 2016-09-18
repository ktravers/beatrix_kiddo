class UserPreview < ActionMailer::Preview
  def send_save_the_date
    UserMailer.send_save_the_date(Rsvp.where(event_id: 1).last)
  end

  def send_invite
    UserMailer.send_invite(Rsvp.last)
  end
end
