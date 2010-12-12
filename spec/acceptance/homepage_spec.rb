require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Homepage" do
  scenario "present past event" do
    title, description = "Beer chess", "Happy drinking"
    at_time 1.month.ago do
      past_event = Factory(:event, :title => title, :description => description)
    end
    visit homepage
    within "article.event" do
      page.should have_content(title)
      page.should have_content(description)
      page.should have_content(I18n.t("events.last_event"))
    end
  end

  scenario "present future event" do
    title, description = "Ruby meeting", "Happy hacking"
    at_time 1.month.ago do
      past_event = Factory(:event)
    end
    at_time 1.day.from_now do
      past_event = Factory(:event, :title => title, :description => description)
    end
    visit homepage
    within "article.event" do
      page.should have_content(title)
      page.should have_content(description)
      page.should have_content(I18n.t("events.next_event"))
    end
  end

  scenario "present no events" do
    Event.count.should == 0
    visit homepage
    within "section#body" do
      page.should have_content(I18n.t("events.no_events_published"))
    end
  end
end
