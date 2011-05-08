require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "News Article Details" do
  before do
    @title, @body, @lead = "Beer chess", "Happy drinking", "Free taxi"
    @news_article = @website.has(:news_article, :title => @title, :body => @body, :lead => @lead)
  end
  
  scenario "should show news article details" do
    @user.visit(news_article_page(@news_article))
    within "section#body" do
      @user.should_not_see_translated("news_articles.read_more")
      @user.should_see(@title).should_see(@lead).should_see(@body)
    end
  end

  scenario "should show comments", :js => true, :net => true do
    @user.visit(news_article_page(@news_article))
    within "#comments" do
      @user.should_find_comments
    end
  end

  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, :label => :online, :content => content)
    @user.visit(news_article_page(@news_article))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, :label => :community, :content => content)
    @user.visit(news_article_page(@news_article))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, :label => :keep_in_touch, :content => content)
    @user.visit(news_article_page(@news_article))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end
end
