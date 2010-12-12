require 'spec_helper'

describe Venue do
  before do
    @venue = Factory.build(:venue)
  end

  it "should have valid factory" do
    @venue.should be_valid
  end

  it "should require address" do
    @venue.address = nil
    @venue.save
    @venue.should have(1).error_on(:address)
  end

  it "should require name" do
    @venue.name = nil
    @venue.save
    @venue.should have_at_least(1).error_on(:name)
  end

  it "should have unique name and address" do
    user = Factory(:user)
    attrs = Factory.attributes_for(:venue).merge(:user => user)
    venue, copy = Venue.create(attrs), Venue.new(attrs)
    copy.save
    copy.should_not be_valid
    copy.address = Factory.next(:address)
    copy.should be_valid
  end

  it "should belong to user" do
    @venue.user = nil
    @venue.save
    @venue.should have(1).error_on(:user)
  end
end
