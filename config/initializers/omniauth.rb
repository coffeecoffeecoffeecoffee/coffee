Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch('TWITTER_CONSUMER_KEY'), ENV.fetch('TWITTER_CONSUMER_SECRET')

  OmniAuth.config.on_failure = proc { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end
