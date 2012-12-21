class AddKarmaFields < ActiveRecord::Migration
  def up
    add_column :users, :irc_points, :integer, default: 0
    add_column :users, :irc_nickname, :string
  end

  def down
    remove_column :users, :irc_points
    remove_column :users, :irc_nickname
  end
end
