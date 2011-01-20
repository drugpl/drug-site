require 'spec_helper'

describe EventsController do
  render_views

  context "GET#index" do
    context "format rss" do
      before do
        Factory(:event, :description => "h1. Description")
        get :index, :format => :rss
      end

      it "should render valid rss", :net => true do
        response.should be_valid_rss
      end
      
      it "should textilize item description" do
        response.body.should match(CGI.escapeHTML("<h1>Description</h1>"))
      end
    end

    context "format ics (iCalendar)" do
      before do
        @event = Factory(:event)
        get :index, :format => :ics
      end

      it "should set text/calendar MIME type" do
        response.headers["Content-Type"].should match "text/calendar"
      end

      it "should include iCalendar attributes" do
        response.body.should match "SUMMARY:#{@event.title}"
        response.body.should match "DESCRIPTION:#{@event.description}"
      end
    end
  end
end
