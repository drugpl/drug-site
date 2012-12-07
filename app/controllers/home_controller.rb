class HomeController < ApplicationController
  def index
    @event            = Event.last
    @previous_events  = Event.previous
    @presentations    = @event.presentations
    @participants     = @event.users
    @new_presentation = Presentation.new
  end
end
