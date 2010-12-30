class EventsController < ApplicationController
  def index
    @events = Event.happened.order("starting_at").paginate(:page => params[:page], :per_page => Event.per_page)
  end

  def show
    @event = Event.find(params[:id])
  end
end
