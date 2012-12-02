class PresentationsController < ApplicationController
  respond_to :html, :json

  def create
    event = Event.find(params[:event_id])
    @presentation = Presentation.new(params[:presentation])
    @presentation.user = current_user
    @presentation.event = event
    current_user.attend(event)

    flash[:notice] = "Presentation added" if @presentation.save

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end
end
