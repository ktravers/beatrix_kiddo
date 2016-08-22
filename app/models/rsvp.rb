class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_presence_of :user, :event
  validates_uniqueness_of :user_id, scope: [:event_id]

  # TODO: allow user to edit rsvp
end
