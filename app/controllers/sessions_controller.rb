class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    
    if current_user.present?
      previous_account = Person.where("#{auth.provider}_uid" => auth.uid).first
      current_user.move_legacy_from(previous_account) unless previous_account.nil?
      current_user.add_omniauth_properties(auth)
    elsif params[:provider].present?
      person = Person.from_omniauth(auth)
      session[:user_id] = person.id
    end

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
