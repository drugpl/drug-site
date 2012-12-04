class SessionsController < ApplicationController
  def create
    if params[:provider].present?
      user = User.from_omniauth(request.env['omniauth.auth'])
    end
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end