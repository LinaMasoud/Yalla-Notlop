Rails.application.routes.draw do
  default_url_options :host => "example.com"
  resources :group_users
  resources :groups
  #resources :friendships
  #resources :orders

  #post 'password/forgot', to: 'password#forgot'
  #post 'password/reset', to: 'password#reset'
  #put 'password/update', to: 'password#update'



  get 'events/index'
  mount ActionCable.server => '/cable'

  resources :orders do
  resources :items
  end
  resources :friendships
  # resources :orders

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
