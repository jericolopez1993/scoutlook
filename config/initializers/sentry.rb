Raven.configure do |config|
  config.dsn = 'https://15bcde5fc36443089126b284c721c0f3:41e23635bee54f108c612000da03cfd0@sentry.io/1302155'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
