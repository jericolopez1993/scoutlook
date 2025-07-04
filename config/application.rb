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
    config.active_job.queue_adapter = :delayed_job
    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('lib')
    # config.time_zone = 'Eastern Time (US & Canada)'
  end
end
