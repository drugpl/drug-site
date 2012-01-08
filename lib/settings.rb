class Settings
  class << self
    def facebook
      read_config('config/facebook.yml')
    end

    def google_maps
      read_config('config/google_maps.yml')
    end

    def email
      read_config('config/email.yml')
    end

    private
    def read_config(path)
      YAML.load(Rails.root.join(path).read)[Rails.env].symbolize_keys
    end
  end
end
