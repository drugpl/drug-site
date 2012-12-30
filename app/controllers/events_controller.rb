class EventsController < ApplicationController
  def index
    scoped        = Event.recent
    @presentation = Presentation.new
    @events       = scoped.happened.page(params[:page])
    @feed_events  = scoped
  end

  def show
    @event        = Event.find(params[:id])
    @presentation = Presentation.new
  end
end
