require 'settings'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def facebook_access_token
    @facebook_access_token ||= begin
      app = FbGraph::Application.new(Settings.facebook[:app_id], secret: Settings.facebook[:app_secret])
      app.get_access_token
    end
  end
end
