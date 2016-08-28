class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.datetime :sent_at
      t.datetime :accepted_at
      t.datetime :declined_at

      t.timestamps
    end
  end
end
