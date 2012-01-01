class NewsArticlesController < ApplicationController
  def index
    @news_articles = NewsArticle.order('created_at DESC').paginate(page: params[:page], per_page: NewsArticle.per_page)
  end

  def show
    @news_article = NewsArticle.find(params[:id])
  end
end
