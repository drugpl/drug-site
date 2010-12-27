require 'spec_helper'

describe Contact do
  before do
    @contact = Factory.build(:contact)
  end
  
  it "should require valid email" do
    @contact.email = "123"
    @contact.should_not be_valid
    @contact.email = nil
    @contact.should_not be_valid
    @contact.email = "test@localhost"
    @contact.should_not be_valid
    @contact.email = "test@example.net"
    @contact.save
    @contact.should have(0).errors_on(:email)
  end

  it "should require message" do
    @contact.message = nil
    @contact.should have(1).error_on(:message)
  end

  it "should require name" do
    @contact.name = nil
    @contact.should have(1).error_on(:name)
  end

  it "should send notification after create" do
    @contact.should_receive(:send_notification)
    @contact.save!
  end

  it "should not be valid with empty field filled" do
    @contact.empty = "not empty"
    @contact.should_not be_valid
  end
end
