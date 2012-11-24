OmniAuth.config.logger = Rails.logger

if Rails.env == "development" || Rails.env == "test"
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "297537827012809", "5b04b2bd4277aaca57da23447f791ef5",
      scope: 'email,read_stream'
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "key", "secret"
  end
end