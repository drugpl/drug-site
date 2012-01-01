require 'spec_helper'

describe NewsArticle do
  before do
    @valid_attributes = {
      title: "a",
      lead:  "b",
      body:  "c"
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

  context "#textilized_body" do
    it "should textilize body" do
      @news_article.body = "*strong*"
      @news_article.publish!
      @news_article.textilized_body.should == "<p><strong>strong</strong></p>"
    end
  end

  context "#textilized_lead" do
    it "should textilize lead" do
      @news_article.lead = "*strong*"
      @news_article.publish!
      @news_article.textilized_lead.should == "<p><strong>strong</strong></p>"
    end
  end
end
