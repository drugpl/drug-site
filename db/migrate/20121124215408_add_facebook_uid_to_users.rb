class AddFacebookUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_uid, :decimal, precision: 20
  end
end
