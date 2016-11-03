module Rsvpable
  extend ActiveSupport::Concern

  included do
    belongs_to :user

    validates_presence_of :user
    validates :accepted_at, absence: true, if: :declined_at
    validates :declined_at, absence: true, if: :accepted_at

    scope :unconfirmed,   -> { where(accepted_at: nil, declined_at: nil) }
    scope :attending,     -> { where.not(accepted_at: nil) }
    scope :not_attending, -> { where.not(declined_at: nil) }
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
