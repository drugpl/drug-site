class EventsController < ApplicationController
  def index
    all_events = Event.recent
    @events = all_events.happened.page(params[:page])
    @events_for_feed = all_events
  end

  def show
    @event = Event.find(params[:id])
    @submitted_presentations = @event.presentations.submitted
    @postponed_presentations = @event.presentations.postponed
    @participants = @event.participants
  end
end
