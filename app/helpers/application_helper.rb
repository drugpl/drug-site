module ApplicationHelper
  PAGES = %w(home events news_articles contact)

  def site_menu
    PAGES.collect { |page| [I18n.t("site_menu.pages.#{page}"), page == 'home' ? root_path : send("#{page}_path")] }
  end

  def load_maps
    javascript_include_tag "http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=#{MAPS_API_KEY}".html_safe, "google-maps.js"
  end

  def load_comments
    javascript_include_tag "disqus-comments.js"
  end

  def load_comments_count
    javascript_include_tag "disqus-comments-count.js"
  end

  def load_twitter_feed
    javascript_include_tag "twitter-feed.js"
  end
end
