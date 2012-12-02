class AttendantsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.json { render json: @event.attendants(access_token: facebook_access_token) }
    end
  end

  def create
    @event = Event.find(params[:event_id])
    case current_user.attend(@event)
      when :already_signed
        redirect_to root_path, notice: "You already signed up for this event!"
      when :signed
        redirect_to root_path, notice: "You signed up for this event."
      else
        redirect_to root_path, notice: "Something went wrong, try again or contact us."  
    end
  end
end
