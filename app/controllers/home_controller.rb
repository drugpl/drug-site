class HomeController < ApplicationController
  def index
    @event        = Event.closest_upcoming
    @presentation = Presentation.new
  end
end
