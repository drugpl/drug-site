require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Event Details" do
  before do
    @title, @description = "Beer chess", "Happy drinking"
    @event = @website.has(:event, :title => @title, :description => @description)
  end
  
  scenario "should show event details" do
    @user.visit(event_page(@event))
    within "section#body" do
      @user.should_not_see_translated("events.details_link")
      @user.should_see(@title).should_see(@description)
    end
  end

  # XXX: problem with selenium not seeing db record
  # as a cause from starting async/too early
  scenario "should show map", :js => true, :net => true do
    event = @website.expects(:event, :find)
    @user.visit(event_page(event))
    within "#map" do
      @user.should_find_map
    end
  end

  # XXX: problem with selenium not seeing db record
  # as a cause from starting async/too early
  scenario "should show comments", :js => true, :net => true do
    event = @website.expects(:event, :find)
    @user.visit(event_page(event))
    within "#comments" do
      @user.should_find_comments
    end
  end

  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, :label => :online, :content => content)
    @user.visit(event_page(@event))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, :label => :community, :content => content)
    @user.visit(event_page(@event))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show last published news article" do
    title, body = 'snow', 'snowman'
    at_time 1.day.ago do
      @website.has(:published_news_article, :title => title, :body => body)
    end
    at_time 1.month.ago do
      @website.has(:published_news_article)
    end
    @website.has(:news_article)
    @user.visit(event_page(@event))
    within "aside" do
      @user.should_see(title).should_see(body)
      @user.should_see_translated('news_articles.read_more')
      @user.should_see(1.day.ago.strftime("%d/%m/%y"))
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, :label => :keep_in_touch, :content => content)
    @user.visit(event_page(@event))
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end
end
