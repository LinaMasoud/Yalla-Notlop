Rails.application.routes.draw do
  get 'password_resets/new'
 
  default_url_options :host => "example.com"
  resources :group_users
  resources :groups
  resources :friendships
  #resources :orders
  resources :password_resets

  post '/friendships/create', to: 'friendships#create'
  post '/friendships/destroy', to: 'friendships#destroy'

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
  # get '/orderFinish/:orderId' => 'orders#finish'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  get 'home/index'
  root 'home#index'
  post '/order_joined/add' => 'order_joined#add'
  post '/order_joined/cancel' => 'order_joined#cancel'
  post '/orders/finish' => 'orders#finish'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
