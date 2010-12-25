class ContentBlocksCell < Cell::Rails
  def snippet
    @snippet = ContentBlocks::Models::Snippet[@opts[:label]]
    render
  end

  def news_article
    @news_articles = ContentBlocks::Models::NewsArticle.published.limit(@opts[:limit] || 3)
    render
  end
end
