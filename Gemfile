source "http://gems.ruby-china.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "5.0.6"
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'activeadmin', '1.1.0'
gem 'devise', '4.3.0'
gem 'cancancan', '2.0.0'
gem 'draper', '3.0.0'
gem 'pundit', '1.1.0'
gem "paperclip", "~> 5.0.0"
gem 'aasm', '4.12.2'
# 千帆渡朋友圈发布平台
gem 'moment', github: 'pengxian/qfd-moment'
# 队列
gem 'sinatra', '2.0.0'
gem 'sidekiq', '5.0.5'
# 定时任务
gem 'rufus-scheduler', '3.4.2'
# Redis
gem 'redis', '4.0.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'pry-nav', '0.2.3'
  gem 'pry-rails', '0.3.2'
  gem 'mina', '1.2.1'
  gem 'mina-sidekiq', '1.0.2'
end

group :production do
  gem 'unicorn', '5.3.1'
  gem 'unicorn-worker-killer', '0.4.4'
end
