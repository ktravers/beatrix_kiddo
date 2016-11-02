class CreatePlusOnes < ActiveRecord::Migration
  def change
    create_table :plus_ones do |t|
      t.integer :user_id, null: false
      t.integer :guest_id
      t.integer :rsvp_id, null: false
      t.datetime :accepted_at
      t.datetime :declined_at

      t.timestamps
    end
  end
end
