class AttendantsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.json { render json: @event.attendants(access_token: facebook_access_token) }
    end
  end
end
