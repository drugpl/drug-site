class AttendantsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    respond_to do |format|
      format.json { render :json => @event.attendants }
    end
  end
end
