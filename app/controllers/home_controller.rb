class HomeController < ApplicationController

  def index
    @presentation            = Presentation.new
    @event                   = Event.closest_upcoming
    @submitted_presentations = @event.presentations.submitted
    @postponed_presentations = @event.presentations.postponed
    @participants            = @event.participants

    render 'events/show'
  end

end
