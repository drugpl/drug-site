require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Events" do
  scenario "should show last published news article" do
    title, body = 'snow', 'snowman'
    at_time 1.day.ago do
      @website.has(:published_news_article, :title => title, :body => body)
    end
    at_time 1.month.ago do
      @website.has(:published_news_article)
    end
    @website.has(:news_article)
    @user.visit(events_page)
    within "aside" do
      @user.should_see(title).should_see(body)
      @user.should_see_translated('news_articles.read_more')
      @user.should_see(1.day.ago.strftime("%d/%m/%y"))
    end
  end

  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, :label => :online, :content => content)
    @user.visit(events_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, :label => :community, :content => content)
    @user.visit(events_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, :label => :keep_in_touch, :content => content)
    @user.visit(events_page)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end

  scenario "should list past events" do
    title, description, future_title = "Beer chess", "Happy drinking", "Vodka tasting"
    at_time 1.day.from_now do
      @website.has(:event, :title => future_title)
    end
    at_time 1.month.ago do
      @website.has(:event, :title => title, :description => description)
    end
    @user.visit(events_page)
    within "section#body" do
      @user.should_see(title).should_see(description)
      @user.should_not_see(future_title)
    end
  end

  scenario "should paginate events" do
    Event.per_page = 1
    2.times do |i|
      @website.has(:event, :title => "event #{i}")
    end
    @user.visit(events_page)
    within "section#body" do
      @user.should_see("event 1").should_not_see("event 0")
    end
    within "section#body .pagination" do
      @user.should_see_translated("next_page")
      @user.should_see_translated("previous_page")
    end
  end

  scenario "should present link to event details" do
    title, description = "Beer chess", "Happy drinking"
    @website.has(:event, :title => title, :description => description)
    @user.visit(events_page)
    within "section#body" do
      @user.should_see_translated("events.details_link")
    end
    @user.click_translated("events.details_link")
    @user.should_see(title).should_see(description)
  end
end
