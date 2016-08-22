class Event < ActiveRecord::Base
  has_many :users, through: :rsvps

  validates :name, uniqueness: true

  def venue_map_url
    # https://www.google.com/maps/place/Dumbo,+Brooklyn,+NY
    "https://www.google.com/maps/place/#{venue_address.gsub(' ', '+')}"
  end
end
