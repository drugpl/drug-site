class ChangeUidDecimalsToStrings < ActiveRecord::Migration
  def up
    change_column :users, :facebook_uid, :string
    change_column :users, :github_uid, :string
  end

  def down
    change_column :users, :facebook_uid, :decimal, precision: 20
    change_column :users, :github_uid, :string, precision: 20
  end
end
