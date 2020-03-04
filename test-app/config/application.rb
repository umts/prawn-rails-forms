require_relative 'boot'

require "action_controller/railtie"
require "action_view/railtie"
Bundler.require(*Rails.groups)

module TestApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.system_tests = nil
  end
end
