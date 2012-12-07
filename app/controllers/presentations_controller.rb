class PresentationsController < ApplicationController
  respond_to :html, :json

  def create
    event = Event.find(params[:event_id])
    @presentation = event.presentations.create(params[:presentation])
    @presentation.user = current_user
    current_user.attend(event)

    flash[:notice] = "Presentation added" if @presentation.save

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end
end
