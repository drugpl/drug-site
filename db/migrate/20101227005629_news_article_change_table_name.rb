class NewsArticleChangeTableName < ActiveRecord::Migration
  def self.up
    rename_table :content_blocks_news_articles, :news_articles
  end

  def self.down
    rename_table :news_articles, :content_blocks_news_articles
  end
end
