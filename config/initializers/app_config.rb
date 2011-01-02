AppConfig.setup do |config|
  config[:env] = Rails.env
  config[:storage_method] = :yaml
  config[:path] = Rails.root.join('config', 'settings.yml')
end
