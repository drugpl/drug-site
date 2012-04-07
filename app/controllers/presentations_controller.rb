class PresentationsController < ApplicationController
  respond_to :html, :json

  def create
    @presentation       = Presentation.new(params[:presentation])
    @presentation.event = Event.last
    flash[:notice] = "Prezentacja stworzona" if @presentation.save
    respond_with(@presentation)
  end

end
