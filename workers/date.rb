require 'date'

module Tutoriel
  module Workers
    class Date
      include Sidekiq::Worker
      include Tutoriel::Helpers::Backend
      sidekiq_options retry: false

      def perform
        date = DateTime.now
        get_redis.upsert(entry: 'date', data: date)
      end
    end
  end
end
