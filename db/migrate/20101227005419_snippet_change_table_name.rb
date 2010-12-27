class SnippetChangeTableName < ActiveRecord::Migration
  def self.up
    rename_table :content_blocks_snippets, :snippets
  end

  def self.down
    rename_table :snippets, :content_blocks_snippets
  end
end
