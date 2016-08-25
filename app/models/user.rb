class User < ActiveRecord::Base
  has_many :rsvps
  has_many :events, through: :rsvps

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, scope: [:first_name, :last_name]

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def invited_to?(event_id)
    !!self.rsvps.find_by(event_id: event_id)
  end

  def rsvped_to?(event_id)
    rsvp = self.rsvps.find_by(event_id: event_id)
    return false unless rsvp

    rsvp.accepted_at || rsvp.declined_at
  end

  def attending?(event_id)
    rsvp = self.rsvps.find_by(event_id: event_id)
    return false unless rsvp

    !!rsvp.accepted_at
  end
end
