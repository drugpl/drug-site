require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Drug
  class Application < Rails::Application
    config.time_zone = 'Warsaw'
    config.i18n.default_locale = :pl
    config.action_view.javascript_expansions[:defaults] = %w(jquery)
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false, :view_specs => false, :controller_specs => false, :helper_specs => false
      g.helper false
    end
  end
end
