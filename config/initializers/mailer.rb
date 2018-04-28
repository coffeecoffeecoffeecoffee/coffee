ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: Rails.application.credentials.sendgrid[:api_key],
  domain: 'coffeecoffeecoffee.coffee',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain
}
