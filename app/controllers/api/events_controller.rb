class Api::EventsController < ApplicationController
  respond_to :json

  def index
    @events = Event.all
    @events.map! { |e| EventPresenter.new(e) }

    respond_with(:events => @events)
  end

  def show
    @event = Event.find(params[:id])
    respond_with(EventPresenter.new(@event))
  end
end
