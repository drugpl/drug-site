class RenameUsersToPeople < ActiveRecord::Migration
  def up
    rename_table :users, :people
  end

  def down
    rename_table :people, :users
  end
end
