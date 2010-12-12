require 'spec_helper'

describe Event do
  before do
    @event = Factory.build(:event)
  end

  it "should have valid factory" do
    @event.should be_valid
  end
  
  it "should require title" do
    @event.title = nil
    @event.save
    @event.should have(1).error_on(:title)
  end 

  it "should require starting datetime" do
    @event.starting_at = nil
    @event.save
    @event.should have(1).error_on(:starting_at)
  end

  it "ending datetime should be after starting datetime" do
    @event.ending_at = @event.starting_at
    @event.save
    @event.should have(1).error_on(:ending_at)
    @event.ending_at = @event.starting_at + 1.hour
    @event.save
    @event.should be_valid
  end
  
  it "should belong to venue" do
    @event.venue = nil
    @event.save
    @event.should have(1).error_on(:venue)
  end
  
  it "should belong to user" do
    @event.user = nil
    @event.save
    @event.should have(1).error_on(:user)
  end
end
