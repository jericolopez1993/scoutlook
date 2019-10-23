Raven.configure do |config|
  config.dsn = 'https://92b75050203e49b3904fbcb823032b2c:0faf76f6d60044d5929f7d30b3649d71@sentry.io/1304853'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.excluded_exceptions += ['I18n::InvalidLocaleData']
  config.environments = ['staging', 'production']
end
