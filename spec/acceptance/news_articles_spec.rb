require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "News Articles" do
  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, label: :online, content: content)
    @user.visit(news_articles_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, label: :community, content: content)
    @user.visit(news_articles_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, label: :keep_in_touch, content: content)
    @user.visit(news_articles_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end

  scenario "should list news articles" do
    title, body, lead = "Beer chess", "Happy drinking", "Free taxi"
    @website.has(:news_article, title: title, body: body, lead: lead)
    @user.visit(news_articles_page)
    within "section#body" do
      @user.should_see(title).should_see(lead)
      @user.should_not_see(body)
    end
  end

  scenario "should list news articles with body if lead not present" do
    title, body, lead = "Beer chess", "Happy drinking", nil
    @website.has(:news_article, title: title, body: body, lead: lead)
    @user.visit(news_articles_page)
    within "section#body" do
      @user.should_see(title).should_see(body)
    end
  end

  scenario "should paginate news articles" do
    NewsArticle.per_page = 1
    2.times do |i|
      @website.has(:news_article, title: "article #{i}")
    end
    @user.visit(news_articles_page)
    within "section#body" do
      @user.should_see("article 1").should_not_see("article 0")
    end
    within "section#body .pagination" do
      @user.should_see_translated("next_page")
      @user.should_see_translated("previous_page")
    end
  end

  scenario "should present link to news article details" do
    title = "Beer chess"
    @website.has(:news_article, title: title)
    @user.visit(news_articles_page)
    within "section#body" do
      @user.should_see_translated("news_articles.read_more")
    end
    @user.click_translated("news_articles.read_more")
    @user.should_see(title)
  end
end
