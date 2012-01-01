module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def events_page
    "/events"
  end

  def event_page(event)
    "/events/#{event.id}"
  end

  def news_articles_page
    "/news_articles"
  end

  def news_article_page(news_article)
    "/news_articles/#{news_article.id}"
  end

  def contact_page
    "/contact"
  end
end

RSpec.configuration.include NavigationHelpers, type: :acceptance
