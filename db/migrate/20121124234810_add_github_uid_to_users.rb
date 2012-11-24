class AddGithubUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_uid, :decimal, precision: 20
  end
end
