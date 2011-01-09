class EventsController < ApplicationController
  def index
    all_events = Event.order("starting_at DESC")
    @events = all_events.happened.paginate(:page => params[:page], :per_page => Event.per_page)
    @events_for_feed = all_events
  end

  def show
    @event = Event.find(params[:id])
  end
end
