class EventsController < ApplicationController
  def index
    scoped        = Event.recent
    @presentation = Presentation.new
    @events       = scoped #.happened
    @feed_events  = scoped
  end

  def admin
    @events = Event.recent
  end

  def show
    @event        = Event.find(params[:id])
    @presentation = Presentation.new
  end
end
