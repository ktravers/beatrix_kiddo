class PlusOne < ActiveRecord::Base
  include Rsvpable
  belongs_to :guest, class_name: User
  belongs_to :rsvp

  validates_presence_of :rsvp
  validates_uniqueness_of :user_id, scope: [:rsvp_id]

  delegate :first_name, :last_name, :email, to: :guest, allow_nil: true
  delegate :sent_at, to: :rsvp, allow_nil: true

  def full_name
    guest ? guest.full_name : "#{user.full_name}'s +1"
  end

  def event_slug
    rsvp.event.slug
  end
end
