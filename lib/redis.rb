require 'redis'
# TODO : inclure ce code dans la lib
module Backends
  class RedisClient
    include Singleton
    attr_accessor :spool

    def initialize
      conf = { url: get_config.backend.redis.tutoriel.url }
      @store = ::Redis.new conf
    end

    def list
      @store.keys('*_*')
    end

    def get(entry:)
      @store.get(entry)
    end

    def delete(entry:)
      @store.del entry
    end

    def upsert(entry: , data:)
      @store.set entry, data
    end

    alias update upsert
    alias create upsert

    def exist?(key:)
      !@store.get(key).nil?
    end

    def flush
      @store.flushdb
    end
  end
end
