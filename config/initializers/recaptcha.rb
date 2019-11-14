Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.recaptcha[:api_key]
  config.secret_key = Rails.application.credentials.recaptcha[:api_secret]
end
