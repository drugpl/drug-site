class ApplicationController < ActionController::Base
  protect_from_forgery

  def facebook_access_token
    @facebook_access_token ||= begin
      app = FbGraph::Application.new(AppConfig[:facebook_app_id], secret: AppConfig[:facebook_app_secret])
      app.get_access_token
    end
  end
end
