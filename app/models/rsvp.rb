class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_presence_of :user, :event
  validates_uniqueness_of :user_id, scope: [:event_id]

  scope :unsent,        -> { where(sent_at: nil) }
  scope :unconfirmed,   -> { where(accepted_at: nil, declined_at: nil) }
  scope :attending,     -> { where.not(accepted_at: nil) }
  scope :not_attending, -> { where.not(declined_at: nil) }

  def sent!
    update(sent_at: Time.now)
  end

  def accepted!
    update(accepted_at: Time.now)
  end

  def declined!
    update(declined_at: Time.now)
  end
end
