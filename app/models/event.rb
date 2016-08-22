class Event < ActiveRecord::Base
  has_many :users, through: :user_events

  validates :name, uniqueness: true
end
