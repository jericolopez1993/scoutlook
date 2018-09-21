require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PbPlatform
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_controller.allow_forgery_protection = false
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host:'ec2-35-183-0-148.ca-central-1.compute.amazonaws.com'}
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      :user_name => 'kevinmarceloph',
      :password => 'bd2ejj36epxP3Qcn',
      :domain => 'ec2-35-183-0-148.ca-central-1.compute.amazonaws.com',
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
    }
    # config.action_mailer.smtp_settings = {
    #     :address              => "smtp.gmail.com",
    #     :port                 => 587,
    #     :domain               => "gmail.com",
    #     :user_name            => "opinionatedstore@gmail.com",
    #     :password             => "strivers",
    #     :authentication       => :plain,
    #     :enable_starttls_auto => true
    # }

  end
end
