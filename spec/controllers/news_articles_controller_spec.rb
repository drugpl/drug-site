require 'spec_helper'

describe NewsArticlesController do
  render_views

  context "GET#index" do
    it "should render valid rss" do
      Factory(:news_article)
      get :index, :format => :rss
      response.should be_valid_rss
    end
  end
end
