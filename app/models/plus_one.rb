class PlusOne < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest, class_name: User
  belongs_to :rsvp

  validates_presence_of :user_id, :rsvp_id
  validates_uniqueness_of :user_id, scope: [:rsvp_id]

  delegate :first_name, :last_name, :email, :full_name, to: :guest, allow_nil: true
end
