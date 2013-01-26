class ParticipantsMessageMailer < ActionMailer::Base
  default from: ENV['CONTACT_EMAIL']

  def participants_message(participants_message, receiver)
    @message = participants_message
    mail to: receiver.email, subject: @message.subject
  end
end
