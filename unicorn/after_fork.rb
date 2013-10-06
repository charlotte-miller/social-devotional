require 'extensions/third_party/sidekiq_middleware'

# Unicorn master loads the app then forks off workers 
# Because of the way # Unix forking works, we need to make sure we aren't                            
# using any of the parent's sockets, e.g. db connection
ActiveRecord::Base.establish_connection
  
# Reset the connections to memcache-based object and session stores - this                           
# is using a dalli-specific reset method. Otherwise you'll get wacky cache                           
# misreads (returning incorrect values for the requested key).                                       
Rails.cache.reset if Rails.cache.respond_to?(:reset)                                                 
Rails.application.config.session_options[:cache] if Rails.application.config.session_options[:cache]

redis_url = "redis://#{AppConfig.redis.host}:#{AppConfig.redis.port}"
redis_namespace = "social_devotional.#{Rails.env}"
redis_config = {:url => redis_url, :namespace => redis_namespace}

Sidekiq.configure_client do |config|
  config.redis = redis_config
  config.client_middleware do |chain|
    chain.add RequestStore::SidekiqMiddleware
  end
end
