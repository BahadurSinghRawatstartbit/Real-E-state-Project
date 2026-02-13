# config/initializers/redis.rb
Rails.application.configure do
  config.cache_store = :redis_cache_store, {
    url: ENV.fetch("REDIS_URL", "redis://red-d67f5hjh46gs73fvv5i0:6379"),
    # Rails recommends allkeys-lfu as a default maxmemory-policy
    maxmemory_policy: :allkeys_lfu 
  }
end
