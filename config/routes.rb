Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root "users#index"

  resources :users, only: [:show, :index]
  resources :tests, only: [:new, :create, :show, :index]
end
