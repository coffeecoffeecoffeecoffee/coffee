Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = %i[post get]
  OmniAuth.config.silence_get_warning = true

  provider :twitter,
           Rails.application.credentials.twitter[:consumer_key],
           Rails.application.credentials.twitter[:consumer_secret]
end
