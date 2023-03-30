Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # omniauth
  get '/auth/:provider/callback' => 'oauth_callbacks#create'
  get '/auth/failure' => 'oauth_callbacks#failure'

  # Custom logout
  match '/logout', :to => 'oauth_callbacks#destroy', via: :all

  # Defines the root path route ("/")
  root "home#index"
  
end
