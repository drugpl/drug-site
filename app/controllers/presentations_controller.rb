class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.includes('event').order('events.starting_at')
    render json: @presentations.to_json
  end
end
