source "https://rubygems.org"

ruby "2.6.2"

gem "administrate"
gem "bootsnap", require: false
gem "factory_bot_rails"
gem "friendly_id"
gem "httparty"
gem "icalendar"
gem "jbuilder"
gem "meta-tags"
gem "mini_racer", platforms: :ruby
gem "normalize-rails"
gem "omniauth"
gem "omniauth-twitter"
gem "pg"
gem "puma"
gem "rails"
gem "sass-rails"
gem "turbolinks"
gem "uglifier"

group :development do
  gem "erb_lint", require: false
  gem "listen"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "spring"
  gem "spring-watcher-listen"
  gem "web-console"
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails"
end

group :production do
  gem "newrelic_rpm"
  gem "sentry-raven"
end

group :test do
  gem "capybara"
  gem "json_matchers"
  gem "json_schema"
  gem "oas_parser"
  gem "shoulda"
  gem "vcr"
  gem "webmock"
end
