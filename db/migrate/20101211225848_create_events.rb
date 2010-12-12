class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :user_id, :null => false
      t.integer :venue_id, :null => false
      t.datetime :starting_at, :null => false
      t.datetime :ending_at

      t.timestamps :null => false
    end
  end

  def self.down
    drop_table :events
  end
end
