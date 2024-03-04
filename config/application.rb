require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjectDesafio
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Responders
    config.app_generators.scaffold_controller :responders_controller
    config.responders.flash_keys = [ :success, :error ]
    config.active_record.belongs_to_required_by_default = false
    config.active_job.queue_adapter = :sidekiq
    config.action_controller.include_all_helpers = true


    config.time_zone = 'America/Sao_Paulo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = 'pt-BR'
    config.exceptions_app = self.routes

    Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M:%S"
    Date::DATE_FORMATS[:default] = "%d/%m/%Y"

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name:  ENV['MAILER_USER_NAME'],
      password: ENV['MAILER_PASSWORD'],
      domain: ENV['MAILER_DOMAIN'],
      address: ENV['MAILER_ADDRESS'],
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
    }

    config.action_mailer.raise_delivery_errors = true

    RenderAsync.configure do |config|
      config.jquery = true # This will render jQuery code, and skip Vanilla JS code
      config.turbolinks = false # Enable this option if you are using Turbolinks 5+
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
