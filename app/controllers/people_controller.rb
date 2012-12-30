class PeopleController < ApplicationController
  class UnpublicizedPersonException < StandardError; end

  def index
    @people = Person.publicized.sort_by {|u| u.karma }
  end

  def show
    @person = Person.find(params[:id])
    raise UnpublicizedPersonException unless @person.publicized? || @person == current_user
  rescue UnpublicizedPersonException
    redirect_to people_path, notice: "You are not allowed to see this profile."
  end

  def edit
    @person = current_user
  end

  def update
    @person = current_user
    @person.update_attributes!(params[:person])
    redirect_to edit_people_path, notice: "Your profile was updated successfully."
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def change_membership
    current_user.change_membership!
    redirect_to edit_people_path
  end
end
