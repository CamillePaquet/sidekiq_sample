module Tutoriel
  module Helpers
    module Backend
      def get_redis
        return Backends::RedisClient.instance
      end
    end
  end
end