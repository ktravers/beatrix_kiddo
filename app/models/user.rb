class User < ActiveRecord::Base
  has_many :rsvps
  has_many :events, through: :rsvps

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, scope: [:first_name, :last_name]

  def self.fuzzy_match(email)
    find_by('levenshtein(lower(email), lower(?)) <= 3', email.strip)
  end

  def full_name
    "#{first_name.strip} #{last_name.strip}"
  end

  def admin?
    [1,2].include?(id)
  end
end
