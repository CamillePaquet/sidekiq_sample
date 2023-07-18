module Tutoriel
  module Workers
    class Date
      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform
        
      end
    end
  end
end
