require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Homepage" do
  scenario "should show past event if no upcoming" do
    title, description = "Beer chess", "Happy drinking"
    at_time 1.month.ago do
      @website.has(:event, :title => title, :description => description)
    end
    @user.visit(homepage)
    within "article.event" do
      @user.should_see(title, description)
      @user.should_see_translated("events.last_event")
    end
  end

  scenario "should show future event if present" do
    title, description = "Ruby meeting", "Happy hacking"
    at_time 1.month.ago do
      @website.has(:event)
    end
    at_time 1.day.from_now do
      @website.has(:event, :title => title, :description => description)
    end
    @user.visit(homepage)
    within "article.event" do
      @user.should_see(title, description)
      @user.should_see_translated("events.next_event")
    end
  end

  scenario "should show message when no events" do
    @user.visit(homepage)
    within "section#body" do
      @user.should_see_translated("events.no_events_published")
    end
  end

  scenario "should show 'About us' snippet" do
    content = "Czterej pancerni i pies"
    @website.has(:published_snippet, :label => :about_us, :content => content)
    @user.visit(homepage)
    within "section#about" do
      @user.should_see(content).should_see_translated('snippets.about')
    end
  end

  scenario "should show 'Drug online' snippet" do
    content = "giithub.com/dopalacze"
    @website.has(:published_snippet, :label => :online, :content => content)
    @user.visit(homepage)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.online')
    end
  end

  scenario "should show 'Ruby in Poland' snippet" do
    content = "forum Ruby"
    @website.has(:published_snippet, :label => :community, :content => content)
    @user.visit(homepage)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.community')
    end
  end

  scenario "should show 'Keep in touch' snippet" do
    content = "RSS"
    @website.has(:published_snippet, :label => :keep_in_touch, :content => content)
    @user.visit(homepage)
    within "aside" do
      @user.should_see(content).should_see_translated('snippets.keep_in_touch')
    end
  end

  scenario "should provide auto discovery links to feeds" do
    @user.visit(homepage)
    @user.should_discover_rss("http://feeds.feedburner.com/DRUG_Spotkania.xml")
    @user.should_discover_rss("http://feeds.feedburner.com/DRUG_Aktualnosci.xml")
  end

  scenario "should show event on map", :js => true, :net => true do
    at_time 1.day.from_now do
      @website.has(:event)
    end
    @user.visit(homepage)
    within "#map" do
      @user.should_find_map
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
    @user.visit(homepage)
    within "aside" do
      @user.should_see(title).should_see(body)
      @user.should_see_translated('news_articles.read_more')
    end
  end

  scenario "should show Twitter feed", :js => true, :net => true do
    @user.visit(homepage)
    within "#twitter-feed" do
      @user.should_see_translated('twitter_feed.title')
      @user.should_find_twitter_entries
    end
  end
end
