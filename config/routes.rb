Rails.application.routes.draw do

  root "admin/im_posts#index"

  # devise
  devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin
  ActiveAdmin.routes(self)
  # sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
