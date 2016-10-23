class CreatePlusOnes < ActiveRecord::Migration
  def change
    create_table :plus_ones do |t|
      t.integer :user_id, null: false
      t.integer :guest_id, null: false
      t.integer :rsvp_id, null: false

      t.timestamps
    end
  end
end
