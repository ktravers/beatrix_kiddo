class AddSentAcceptedDeclinedAtToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :sent_at, :datetime
    add_column :rsvps, :accepted_at, :datetime
    add_column :rsvps, :declined_at, :datetime
  end
end
