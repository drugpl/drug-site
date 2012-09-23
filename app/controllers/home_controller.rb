class HomeController < ApplicationController
  def index
    @event           = Event.last
    @previous_events = Event.previous
    @presentations   = Presentation.all
  end
end
