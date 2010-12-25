class CreateContentBlocksNewsArticles < ActiveRecord::Migration
  def self.up
    create_table :content_blocks_news_articles, :force => true do |t|
      t.string :title, :null => false
      t.text :body
      t.text :lead
      t.string :status
      t.timestamps :null => false
    end
  end

  def self.down
    drop_table :content_blocks_news_articles
  end
end
