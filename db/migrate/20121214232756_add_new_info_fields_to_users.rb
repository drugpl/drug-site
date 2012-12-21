class AddNewInfoFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rss_url, :string
    add_column :users, :description, :text
  end
end
