require 'spec_helper'

describe NewsArticlesController do
  render_views

  context "GET#index" do
    before(:all) do
      Factory(:news_article, :body => "h1. News", :lead => "h2. Article")
    end

    context "format rss" do
      before do
        get :index, :format => :rss
      end

      it "should render valid rss" do
        response.should be_valid_rss
      end
  
      it "should textilize item description"  do
        response.body.should match(CGI.escapeHTML("<h1>News</h1>"))
        response.body.should match(CGI.escapeHTML("<h2>Article</h2>"))
      end
    end
  end
end
