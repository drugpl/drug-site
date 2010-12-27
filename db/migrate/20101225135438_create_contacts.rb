class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name, :null => false
      t.text :message, :null => false
      t.string :email, :null => false

      t.timestamps :null => false
    end
  end

  def self.down
    drop_table :contacts
  end
end
