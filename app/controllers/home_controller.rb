class HomeController < ApplicationController
  def index
    @event = Event.last
    @previous_events = Event.previous
    @presentations = @event.presentations.not_postponed
    @postponed_presentations = @event.presentations.postponed
    @participants = @event.users
    @new_presentation = Presentation.new
  end
end
