require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Homepage" do
  scenario "show past event if no upcoming" do
    title, description = "Beer chess", "Happy drinking"
    at_time 1.month.ago { @website.has_event(title, description) }
    @user.visit(homepage)
    within "article.event" do
      @user.should_see(title, description)
      @user.should_see_translated("events.last_event")
    end
  end

  scenario "show future event if present" do
    title, description = "Ruby meeting", "Happy hacking"
    at_time 1.month.ago { @website.has_event }
    at_time 1.day.from_now { @website.has_event(title, description) }
    @user.visit(homepage)
    within "article.event" do
      @user.should_see(title, description)
      @user.should_see_translated("events.next_event")
    end
  end

  scenario "show message when no events" do
    @user.visit(homepage)
    within "section#body" do
      @user.should_see_translated("events.no_events_published")
    end
  end

  scenario "show event on map", :js => true do
    @website.should_respond_with(:event, :last)
    @user.visit(homepage)
    within "#map" { @website.should_have_map }
  end
end
