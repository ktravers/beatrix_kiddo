class PlusOne < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest, class_name: User
  belongs_to :rsvp

  validates_presence_of :user_id, :rsvp_id
  validates_uniqueness_of :user_id, scope: [:rsvp_id]

  delegate :first_name, :last_name, :email, :full_name, to: :guest, allow_nil: true

  def event_slug
    rsvp.event.slug
  end

  def confirmed?
    !!accepted_at || !!declined_at
  end

  def unconfirmed?
    accepted_at.blank? && declined_at.blank?
  end
end
