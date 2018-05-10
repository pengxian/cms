HOST = YAML::load_file("#{Rails.root}/config/host.yml")[Rails.env]
# gem moment host
Moment.configure do |config|
  config.api_host = YAML::load_file("#{Rails.root}/config/host.yml")[Rails.env]['qianfandu_host']
end
