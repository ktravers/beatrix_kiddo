class User < ActiveRecord::Base
  has_many :events, through: :user_events

  validates :email, uniqueness: true
end
