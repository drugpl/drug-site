class SessionsController < ApplicationController
  def create
    if current_user.present?
      current_user.add_omniauth_properties(request.env['omniauth.auth'])
    elsif params[:provider].present?
      person = Person.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = person.id
    end

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
