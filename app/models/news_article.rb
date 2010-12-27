require 'content_blocks/models/news_article'

module ContentBlocks
  module Models
    class NewsArticle
      cattr_accessor :per_page
      @@per_page = 5
    end
  end
end
