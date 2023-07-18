require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

require_relative 'runner'
require_relative 'config/init'

secret_key = SecureRandom.hex(32)
use Rack::Session::Cookie, secret: secret_key, same_site: true, max_age: 86400
run Sidekiq::Web
