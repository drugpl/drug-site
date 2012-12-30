class PresentationsController < ApplicationController
  respond_to :html, :json

  def create
    event = Event.find(params[:event_id])
    @presentation = event.presentations.create(params[:presentation])
    @presentation.speaker = current_user
    current_user.attend(event)

    flash[:notice] = "Presentation added" if @presentation.save

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end

  def postpone
    presentation = Presentation.find(params[:id])
    presentation.postpone!

    flash[:notice] = "Presentation postponed"

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end

  def cancel_postponement
    event = Event.find(params[:event_id])
    presentation = Presentation.find(params[:id])
    presentation.cancel_postponement!

    current_user.attend(event) unless current_user.attend?(event)

    flash[:notice] = "Presentation postponement cancelled"

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end

  def destroy
    presentation = Presentation.find(params[:id])
    presentation.destroy

    flash[:notice] = "Presentation cancelled"

    respond_with(@presentation) do |format|
      format.html { redirect_to root_path }
    end
  end
end
