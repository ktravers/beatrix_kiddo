class PlusOne < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest, class_name: User
  belongs_to :rsvp
end
