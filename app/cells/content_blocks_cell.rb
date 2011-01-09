class ContentBlocksCell < Cell::Rails
  def snippet
    @snippet = Snippet[@opts[:label]]
    render
  end

  def news_article
    @news_articles = NewsArticle.published.order('created_at DESC').limit(@opts[:limit] || 3)
    render
  end
end
