require 'sidekiq'
require 'sidekiq-cron'
require 'carioca'

environment = ENV['RUBY_ENV'] ? ENV['RUBY_ENV'].to_sym : :development

Carioca::Registry.configure do |spec|
  spec.debug = true
  spec.init_from_file = false
  spec.log_file = '/tmp/tutoriel.log'
  spec.config_file = './config/settings.yml'
  spec.config_root = :runner
  spec.environment = environment
  spec.default_locale = :fr
  spec.log_level = :debug
  spec.locales_load_path << Dir["#{File.expand_path('./config/locales')}/*.yml"]
  spec.debugger_tracer = :logger
end

class ApplicationController < Carioca::Container
  inject service: :configuration
end

require_relative 'helpers/init'
require_relative 'config/init'
require_relative 'workers/init'
require_relative 'lib/init'

Sidekiq::Cron::Job.destroy_all!

Sidekiq.logger.info "Initialisation : #{get_config.application.name}"


Sidekiq::Cron::Job.create(name: "Date",
                          cron: '* * * * *', class: "Tutoriel::Workers::Date")

                          Sidekiq.logger.info "Injection : job Date successfull"

                          Sidekiq.logger.info 'Runner initialized'