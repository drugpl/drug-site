class AttendantsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.json { render json: @event.attendants(access_token: facebook_access_token) }
    end
  end

  def create
    @event = Event.find(params[:event_id])
    
    if current_user.events.include?(@event)
      redirect_to root_path, notice: "You already signed up for this event!"
    else
      current_user.events << @event
      current_user.save!
      redirect_to root_path, notice: "You signed up for this event."
    end
  end
end
