class ContentBlocksCell < Cell::Rails
  def snippet
    @snippet = Snippet[@opts[:label]]
    render
  end

  def news_article
    @news_articles = NewsArticle.published.limit(@opts[:limit] || 3)
    render
  end
end
