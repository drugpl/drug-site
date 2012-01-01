class NewsArticlesAddSlugField < ActiveRecord::Migration
  def up
    add_column :news_articles, :slug, :string
    add_index :news_articles, :slug, unique: true
  end

  def down
    remove_index :news_articles, :column => :slug
    remove_column :news_articles, :slug
  end
end
