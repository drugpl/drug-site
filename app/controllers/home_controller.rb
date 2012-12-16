class HomeController < ApplicationController
  def index
    @event = Event.recent.first
    @presentations = @event.presentations.not_postponed
    @postponed_presentations = @event.presentations.postponed
    @participants = @event.users
    @new_presentation = Presentation.new
    render 'events/show'
  end
end
