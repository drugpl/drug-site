class ContentBlocksCell < Cell::Rails
  def snippet(label, title)
    @snippet = Snippet[label]
    @title   = title
    render
  end

  def twitter_feed
    @user = AppConfig[:twitter_user]
    @list = AppConfig[:twitter_list]
    @url  = AppConfig[:twitter_url]
    render
  end
end
