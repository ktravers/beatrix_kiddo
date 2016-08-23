class User < ActiveRecord::Base
  has_many :rsvps
  has_many :events, through: :rsvps

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, scope: [:first_name, :last_name]

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def invited_to?(event_slug)
    event = Event.find_by(slug: event_slug)
    return false unless event

    !!self.rsvps.find_by(event_id: event.id)
  end
end
