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
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    participation = Participation.where(user_id: current_user.id, event_id: event.id).first
    participation.destroy
    redirect_to root_path, notice: "You resigned from attending to next DRUG : ("
  end
end
