OmniAuth.config.logger = Rails.logger

if Rails.env == "development" || Rails.env == "test"
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "297537827012809", "5b04b2bd4277aaca57da23447f791ef5",
      scope: 'email,read_stream'
    provider :github, "6bfa34fa6519c4a10695", "fd74e299b442056dfd23d822638cd3b918bc248f"
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "key", "secret"
    provider :github, "key", "secret"
  end
end