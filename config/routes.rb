Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create]

  get '/welcome', to: 'sessions#welcome'
  root to: 'sessions#welcome'
  get '/outerwear', to: 'api_interface#outerwear'
  get '/tops', to: 'api_interface#tops'
  get '/bottoms', to: 'api_interface#bottoms'
  get '/accessories', to: 'api_interface#accessories'
  get '/shoes', to: 'api_interface#shoes'
  get '/outfit', to: 'api_interface#outfit'
  get '/logout', to: 'sessions#destroy'
  get '/swap_accessory', to: 'api_interface#swap_accessory'
  get '/swap_outerwear', to: 'api_interface#swap_outerwear'
  get '/swap_top', to: 'api_interface#swap_top'
  get '/swap_bottoms', to: 'api_interface#swap_bottoms'
  get '/swap_shoes', to: 'api_interface#swap_shoes'






  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
