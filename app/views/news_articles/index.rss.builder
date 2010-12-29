xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title I18n.t("news_articles.rss.title")
    xml.description I18n.t("news_articles.rss.description")
    xml.link news_articles_url(:rss)
    
    for news_article in @news_articles
      xml.item do
        xml.title news_article.title
        xml.description news_article.lead.to_s + news_article.body.to_s
        xml.pubDate news_article.created_at.to_s(:rfc822)
        xml.link news_article_url(news_article)
        xml.guid news_article_url(news_article)
      end
    end
  end
end
