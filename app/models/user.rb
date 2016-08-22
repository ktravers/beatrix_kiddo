class User < ActiveRecord::Base
  has_many :events, through: :rsvps

  validates_uniqueness_of :email, scope: [:first_name, :last_name]
end
