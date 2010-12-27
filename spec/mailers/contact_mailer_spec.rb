require "spec_helper"

describe ContactMailer do
  before do
    @contact = Factory.build(:contact)
  end
  describe "contact_message" do
  
    let(:mail) { ContactMailer.contact_message(@contact) }

    it "renders the headers" do
      mail.subject.should == I18n.t('contact_mailer.contact_message.subject')
      mail.to.should == ["info@drug.org.pl"]
      mail.from.should == [@contact.email]
    end

    it "renders the body" do
      mail.body.encoded.should match(@contact.message)
    end
  end

end
