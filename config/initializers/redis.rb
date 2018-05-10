redis_config = YAML.load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]

qianfandu_redis_server = redis_config['qianfandu_redis_server']
qianfandu_redis_port = redis_config['qianfandu_redis_port']
qianfandu_redis_db_num = redis_config['qianfandu_redis_db_num']

$qianfandu_redis = Redis.new(
  host: qianfandu_redis_server,
  port: qianfandu_redis_port,
  db: qianfandu_redis_db_num
)
