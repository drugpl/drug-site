class ApplicationController < ActionController::Base
  protect_from_forgery

  # def facebook_access_token
  #   @facebook_access_token ||= begin
  #     app = FbGraph::Application.new(Settings.facebook[:app_id], secret: Settings.facebook[:app_secret])
  #     app.get_access_token
  #   end
  # end

  private
  def current_user
    @current_user ||= Person.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
