require 'settings'

class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_message.subject
  #
  def contact_message(contact)
    @contact = contact
    mail to: Settings.email[:contact_address], from: @contact.email
  end
end
