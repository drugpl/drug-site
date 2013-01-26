class ParticipantsMessagesController < ApplicationController
  before_filter :fetch_event

  def new
    @message = ParticipantsMessage.new
  end

  def create
    @message = ParticipantsMessage.new(params[:participants_message])
    @message.author = current_user
    @message.event = @event
    @message.save!
    Resque.enqueue(ParticipantsMessagesWorker, self.id)
    redirect_to admin_events_path, notice: "Message sent!"
  rescue ActiveRecord::RecordInvalid => invalid
    @message = invalid.record
    render :new
  end

private

  def fetch_event
    @event = Event.find(params[:event_id])
  end
end