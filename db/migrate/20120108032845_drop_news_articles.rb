class DropNewsArticles < ActiveRecord::Migration
  def up
    drop_table :news_articles
  end
end
