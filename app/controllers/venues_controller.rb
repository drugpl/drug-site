class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    Venue.create!(params[:venue])
    redirect_to venues_path, notice: "New venue added."
  rescue ActiveRecord::RecordInvalid => invalid
    @venue = invalid.record
    render :new
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    Venue.find(params[:id]).update_attributes!(params[:venue])
    redirect_to venues_path, notice: "Venue updated."
  rescue ActiveRecord::RecordInvalid => invalid
    @venue = invalid.record
    render :edit
  end

  def destroy
    Venue.find(params[:id]).destroy
    redirect_to venues_path, notice: "Venue removed."
  end
end