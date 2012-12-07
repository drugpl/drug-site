class UsersController < ApplicationController
  def index
    @users = User.publicized.sort_by {|u| u.karma }
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def change_membership
    current_user.change_membership!
    redirect_to edit_users_path
  end
end
