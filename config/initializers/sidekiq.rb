
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS-PROD'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS-PROD'] }
end
