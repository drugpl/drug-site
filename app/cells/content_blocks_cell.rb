class ContentBlocksCell < Cell::Rails
  def snippet(label, title)
    @snippet = Snippet[label]
    @title   = title
    render
  end

  def news_article(title, limit = nil)
    @news_articles = NewsArticle.published.order('created_at DESC').limit(limit || 3)
    @title         = title
    render
  end

  def twitter_feed
    @user = AppConfig[:twitter_user]
    @list = AppConfig[:twitter_list]
    @url  = AppConfig[:twitter_url]
    render
  end
end
