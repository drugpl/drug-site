class RemoveUserAssociations < ActiveRecord::Migration
  def up
    remove_column :venues, :user_id
    remove_column :events, :user_id
  end
end
