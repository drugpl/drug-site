class SessionsController < ApplicationController
  def create
    session[:user_id] ||= drug_site.omniauth_authenticate(
      current_user,
      request.env['omniauth.auth'],
      params[:provider]
    )
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
