class HomeController < ApplicationController
  def index
    @event = Event.last
    @presentations = @event.presentations
  end
end
