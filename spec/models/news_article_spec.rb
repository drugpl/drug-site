require 'spec_helper'

describe NewsArticle do
  before do
    @valid_attributes = {
      :title => "new location"
    }
    @news_article = NewsArticle.new(@valid_attributes)
  end

  it "should be initially draft" do
    @news_article.save!
    @news_article.draft?.should be_true
  end

  it "should require title" do
    @news_article.title = nil
    @news_article.should have(1).error_on(:title)
  end

  it "should textilize body" do
    @news_article.body = "*strong*"
    @news_article.body.should == "<p><strong>strong</strong></p>"
  end

  it "should textilize lead" do
    @news_article.lead = "*strong*"
    @news_article.lead.should == "<p><strong>strong</strong></p>"
  end

  it "should preserve unformatted body" do
    @news_article.body = "*strong*"
    @news_article.raw_body.should == "*strong*"
  end

  it "should preserve unformatted lead" do
    @news_article.lead = "*strong*"
    @news_article.raw_lead.should == "*strong*"
  end
end
