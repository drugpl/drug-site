class AddGithubNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_nickname, :string
  end
end
