class PlusOne < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest, class_name: User
  belongs_to :rsvp

  validates_presence_of :user_id, :rsvp_id
  validates_uniqueness_of :user_id, scope: [:rsvp_id]

  delegate :first_name, :last_name, :email, to: :guest, allow_nil: true
  delegate :sent_at, to: :rsvp, allow_nil: true

  scope :unconfirmed,   -> { where(accepted_at: nil, declined_at: nil) }
  scope :attending,     -> { where.not(accepted_at: nil) }
  scope :not_attending, -> { where.not(declined_at: nil) }

  # TODO: DRY up code with shared concern (plus one + rsvp)

  def full_name
    guest ? guest.full_name : "#{user.full_name}'s +1"
  end

  def event_slug
    rsvp.event.slug
  end

  def confirmed?
    !!accepted_at || !!declined_at
  end

  def unconfirmed?
    accepted_at.blank? && declined_at.blank?
  end

  def attending?
    !!accepted_at
  end

  def not_attending?
    !!declined_at
  end

  def status
    if accepted_at
      'attending'
    elsif declined_at
      'not attending'
    else
      'unconfirmed'
    end
  end
end
