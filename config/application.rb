require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TPIRuby
  class Application < Rails::Application
    config.load_defaults 5.1

    I18n.config.available_locales = :es
    config.i18n.default_locale = :es
  end
end
