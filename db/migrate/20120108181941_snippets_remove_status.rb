class SnippetsRemoveStatus < ActiveRecord::Migration
  def up
    remove_column :snippets, :status
  end
end
