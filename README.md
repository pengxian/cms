# CMS

QFD内容发布平台

## Getting Started

1. bundle

    $ bundle install

2. migration

    $ rake db:create

    $ rake db:migrate

3. 创建admin用户

    $ rake db:seed

|用户名|密码|
|---|---|
|admin@test.com|admin|

4. 配置相关信息

复制config/database.yml.sample到config/database.yml并填写数据库相关信息
复制config/host.yml.sample到config/host.yml并填写地址相关信息
复制config/redis.yml.sample到config/redis.yml并填写redis相关信息

5. 开启redis服务

6. 开启sidekiq

    $ bundle exec sidekiq

7. 启动Rails项目

    $ rails s

8. 打开地址`http://localhost:3000`查看控制台
