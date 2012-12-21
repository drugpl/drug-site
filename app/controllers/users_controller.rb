class UsersController < ApplicationController
  class UnpublicizedUserException < StandardError; end

  def index
    @users = User.publicized.sort_by {|u| u.karma }
  end

  def show
    @user = User.find(params[:id])
    raise UnpublicizedUserException unless @user.publicized? || @user == current_user
  rescue UnpublicizedUserException
    redirect_to users_path, notice: "You are not allowed to see this profile."
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to edit_users_path, notice: "Your profile was updated successfully."
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def change_membership
    current_user.change_membership!
    redirect_to edit_users_path
  end
end
