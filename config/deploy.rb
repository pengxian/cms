require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'yaml'
require 'mina_sidekiq/tasks'

set :user, 'deployer'

YAML.load(File.open('config/deploy_conf.yml')).keys.each do |server|
  desc %{Set up #{server} for deployment}
  task "setup_#{server}" => :environment do
    load_config(server)
    invoke :setup
  end
  desc %{deploy to #{server} server}
  task "d_#{server}" => :environment do
    load_config(server)
    invoke :deploy
  end

  desc %{start to #{server} server}
  task "s_#{server}" => :environment do
    load_config(server)
    invoke :start
  end

  desc %{restart to #{server} server}
  task "r_#{server}" => :environment do
    load_config(server)
    invoke :restart
  end

  desc %{stop to #{server} server}
  task "stop_#{server}" => :environment do
    load_config(server)
    invoke :stop
  end

  desc %{start to #{server} sidekiq server}
  task "s_sidekiq_#{server}" => :environment do
    load_config(server)
    invoke :'sidekiq:start'
  end

  desc %{restart to #{server} sidekiq server}
  task "r_sidekiq_#{server}" => :environment do
    load_config(server)
    invoke :'sidekiq:restart'
  end

  desc %{stop to #{server} sidekiq server}
  task "stop_sidekiq_#{server}" => :environment do
    load_config(server)
    invoke :'sidekiq:stop'
  end

end

def load_config( server)
  thirdpillar_config =YAML.load(File.open("config/deploy_conf.yml"))
  puts "———-> configuring #{server} server"
  set :domain, thirdpillar_config[server]['domain']
  set :deploy_to, thirdpillar_config[server]['deploy_to']
  set :repository, thirdpillar_config[server]['repository']
  set :branch, thirdpillar_config[server]['branch']
  set :rails_env, thirdpillar_config[server]['rails_env']
end


set :shared_dirs, fetch(:shared_dirs, []).push(
                                              'public/uploads',
                                              'tmp',
                                              )
set :shared_files, fetch(:shared_files, []).push('config/database.yml',
                                                 "config/redis.yml",
                                                 "config/host.yml",
                                                 "config/options.yml",
                                                )

task :environment do
  invoke :'rbenv:load'
end

task :setup => :environment do
  command %[mkdir -p "#{fetch(:deploy_to)}/shared/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log"]

  command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

  command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]
  command  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

    # sidekiq needs a place to store its pid file and log file
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/pids/")
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/log/")

end

desc 'Starts the application'
task :start => :environment do
  command "cd #{fetch(:deploy_to)}/current ; bundle exec unicorn_rails -E production -D -c config/unicorn.rb"
  command  %[echo "-----> deploy start ok."]
  # sidekiq restart
  invoke :'sidekiq:restart'
end

desc 'Stops the application'
task :stop => :environment do
  command %[kill `cat #{fetch(:deploy_to)}/current/tmp/pids/unicorn.pid`]
  command  %[echo "-----> deploy stop ok."]
end

task :restart => :environment do
  report_time do
    invoke :stop
    # sleep 3
    invoke :start
  end
  command  %[echo "-----> deployer restart ok."]
end

desc "Deploys the current version to the server."
task :deploy do

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
  end

end
