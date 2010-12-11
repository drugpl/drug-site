class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  protected

  def set_locale
    I18n.locale = case self.class.name
      when /RailsAdmin/ then :en
      else I18n.default_locale
    end
  end
end
