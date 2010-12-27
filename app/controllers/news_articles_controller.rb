class NewsArticlesController < ApplicationController
  def index
    @news_articles = ContentBlocks::Models::NewsArticle.order('created_at DESC').paginate(:page => params[:page], :per_page => ContentBlocks::Models::NewsArticle.per_page)
  end

  def show
    @news_article = ContentBlocks::Models::NewsArticle.find(params[:id])
  end
end
