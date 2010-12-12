require 'spec_helper'

describe User do
  before do
    @user = Factory.build(:user)
  end

  it "should have valid factories" do
    @user.should be_valid
  end
  
  it "should require email" do
    @user.email = nil
    @user.save
    @user.should have(1).error_on(:email)
  end

  it "should require password" do
    @user.password = nil
    @user.save
    @user.should have(1).error_on(:password)
  end
end
