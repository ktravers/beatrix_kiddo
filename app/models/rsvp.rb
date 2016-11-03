class Rsvp < ActiveRecord::Base
  include Rsvpable

  belongs_to :event
  has_one :plus_one

  validates_presence_of :event
  validates_uniqueness_of :user_id, scope: [:event_id]

  scope :sent,   -> { where.not(sent_at: nil) }
  scope :unsent, -> { where(sent_at: nil) }

  delegate :first_name, :last_name, :email, :full_name, to: :user, allow_nil: true

  def sent!
    update(sent_at: Time.now)
  end

  def confirmed_plus_one?
    return false unless plus_one
    plus_one.confirmed?
  end

  def unconfirmed_plus_one?
    return false unless plus_one
    plus_one.unconfirmed?
  end
end
