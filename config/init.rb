Dir["#{File.dirname(__FILE__)}/*.rb"].sort.each { |file| require file unless File.basename(file) == 'init.rb' }


def get_config
  ApplicationController.configuration.settings
end


Sidekiq.configure_server do |config|
  config.redis = { url: get_config.backend.redis.jobs.url.to_s }
end

Sidekiq.configure_client do |config|
  config.redis = { url: get_config.backend.redis.jobs.url.to_s }
end
