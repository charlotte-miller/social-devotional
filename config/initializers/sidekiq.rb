require 'extensions/third_party/sidekiq_middleware'

redis_url = "redis://#{AppConfig.redis.host}:#{AppConfig.redis.port}"
redis_namespace = "social_devotional.#{Rails.env}"
redis_config = {:url => redis_url, :namespace => redis_namespace}

# Don't initialize here if we are using Unicorn because of pre- and post- forking considerations.
# Please refer to the unicorn folder for the forking hooks.
unless ENV['UNICORN']

  Sidekiq.configure_server do |config|
    config.redis = redis_config
    config.server_middleware do |chain|
      chain.add RequestStore::SidekiqMiddleware
    end
  end

  Sidekiq.configure_client do |config|
    config.redis = redis_config
    config.client_middleware do |chain|
      chain.add RequestStore::SidekiqMiddleware
    end
  end

end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    Sidekiq.configure_client do |config|
      config.redis = redis_config
    end if forked
  end
end