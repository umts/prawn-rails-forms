# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  rails_version = '~> 6.0'
  gem 'actionpack', rails_version
  gem 'actionview', rails_version

  gem 'prawn-rails-forms', path: './', require: false
end

require 'action_controller/railtie'
require 'action_view/railtie'

class TestApp < Rails::Application
  require 'prawn-rails-forms'

  config.load_defaults 6.1
  config.eager_load = false
  config.consider_all_requests_local = true

  PrawnRails.config do |c|
    c.page_layout = :landscape
    c.margin = 30
  end

  routes.append do
    root 'pdf#static', defaults: { format: 'pdf' }
  end
end

class PdfController < ActionController::Base
  append_view_path Rails.root

  def static
    render pdf: 'static'
  end
end

Rails.application.initialize!
