require 'spec_helper'

describe EventsController do
  render_views

  context "GET#index" do
    it "should render valid rss" do
      Factory(:event)
      get :index, :format => :rss
      response.should be_valid_rss
    end
  end
end
