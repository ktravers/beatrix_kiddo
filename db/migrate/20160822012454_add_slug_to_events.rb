class AddSlugToEvents < ActiveRecord::Migration
  def change
    add_column :events, :slug, :string, null: false
  end
end
