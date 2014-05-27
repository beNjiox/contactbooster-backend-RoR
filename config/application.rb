require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ror
  class Application < Rails::Application
    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.test_framework :rspec
    end

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :delete, :patch, :put, :options]
      end
    end

  end
end
