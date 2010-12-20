class CreateContentBlocksSnippets < ActiveRecord::Migration
  def self.up
    create_table :content_blocks_snippets, :force => true do |t|
      t.string :label, :null => false
      t.text :content
      t.string :status
      t.timestamps :null => false
    end
  end

  def self.down
    drop_table :content_blocks_snippets
  end
end
