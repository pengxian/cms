redis_config = YAML.load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]

redis_server = redis_config['redis_server']
redis_port = redis_config['redis_port']
redis_db_num = redis_config['redis_db_num']
# redis_namespace = redis_config['redis_namespace']

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end
