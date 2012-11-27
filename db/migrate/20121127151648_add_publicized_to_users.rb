class AddPublicizedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publicized, :boolean, default: false
  end
end
