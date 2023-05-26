require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      
      if File.exist?(env_file)
        env_vars = File.read(env_file).split
        env_hash = Hash[env_vars.map { |var| var.split('=') }]
        env_hash.each do |key, value|
          ENV[key] = value
        end
      end
    end

  end
end

