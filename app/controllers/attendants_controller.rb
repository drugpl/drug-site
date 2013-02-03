class AttendantsController < ApplicationController
  # def index
  #   @event = Event.find(params[:event_id])
  #   respond_to do |format|
  #     format.json { render json: @event.attendants(access_token: facebook_access_token) }
  #   end
  # end

  def create
    @event = Event.find(params[:event_id])
    current_user.attend!(@event)
    redirect_to root_path, notice: "You signed up for this event."
  rescue Person::AlreadySignedException
    redirect_to root_path, notice: "You already signed up for this event!"
  end

  def destroy
    event = Event.find(params[:event_id])
    participation = Participation.where(person_id: current_user.id, event_id: event.id).first
    participation.destroy

    presentations = current_user.presentations.where(event_id: event.id)
    presentations.each do |presentation|
      presentation.postpone! unless presentation.postponed?
    end

    redirect_to root_path, notice: "You resigned from attending to next DRUG : ("
  end
end
