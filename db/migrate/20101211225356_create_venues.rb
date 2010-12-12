class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :address, :null => false
      t.string :name, :null => false
      t.integer :user_id, :null => false

      t.timestamps :null => false
    end
    add_index :venues, [:name, :address], :unique => true, :name => "venues_name_address_unique_index"
  end

  def self.down
    remove_index :venues, :name => "venues_name_address_unique_index"
    drop_table :venues
  end
end
