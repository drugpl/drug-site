class ParticipantsMessagesWorker
  @queue = :mailer

  def self.perform(participants_message_id)
    @message = ParticipantsMessage.find(participants_message_id)
    @message.event.participants.each do |person|
      ParticipantsMessageMailer.participants_message(@message, person).deliver!
    end
  end
end