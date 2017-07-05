class UserPreview < ActionMailer::Preview
  def send_save_the_date
    UserMailer.send_save_the_date(Rsvp.where(event_id: 1).last)
  end

  def send_official_invitation
    UserMailer.send_official_invitation(Rsvp.where(event_id: 6).last)
  end

  def send_event_invite
    UserMailer.send_event_invite(Rsvp.where(event_id: 2).last)
  end

  def send_announcement
    UserMailer.send_announcement(User.last.email)
  end
end
