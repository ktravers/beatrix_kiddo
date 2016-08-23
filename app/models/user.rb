class User < ActiveRecord::Base
  attr_accessor :random_password
  has_many :events, through: :rsvps

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, scope: [:first_name, :last_name]

  has_secure_password
  validates :password, presence: { on: :create }, length: { minimum: 6, allow_nil: true }, confirmation: true
end
