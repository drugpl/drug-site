class Api::PresentationsController < ApplicationController
  respond_to :json

  def index
    @event          = Event.find_by_id(params[:event_id])
    @presentations  = @event.presentations
    @presentations.map! { |p| PresentationPresenter.new(p) }

    respond_with(:presentations => @presentations)
  end
end
