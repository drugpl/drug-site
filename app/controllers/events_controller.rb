class EventsController < ApplicationController
  def index
    scoped        = Event.recent
    @presentation = Presentation.new
    @events       = scoped #.happened
    @feed_events  = scoped
  end

  def admin
    @events       = Event.recent
  end

  def show
    @event        = Event.find(params[:id])
    @presentation = Presentation.new
  end

  def update
    Event.find(params[:id]).update_attributes!(params[:event])
    flash[:notice] = "Event updated."
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = "Event isn't valid."
  ensure
    redirect_to admin_events_path
  end
end
