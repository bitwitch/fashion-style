Rails.application.routes.draw do
  resources :outfits, only: [:new, :create, :show, :destroy, :index]
  resources :users
  resources :sessions, only: [:new, :create]

  get '/welcome', to: 'sessions#welcome'
  root to: 'sessions#welcome'
  get '/outerwear', to: 'api_interface#outerwear'
  get '/tops', to: 'api_interface#tops'
  get '/pants', to: 'api_interface#pants'
  get '/accessories', to: 'api_interface#accessories'
  get '/shoes', to: 'api_interface#shoes'
  get '/outfit', to: 'api_interface#outfit'
  get '/logout', to: 'sessions#destroy'
  get '/swap_accessories', to: 'api_interface#swap_accessories'
  get '/swap_outerwear', to: 'api_interface#swap_outerwear'
  get '/swap_tops', to: 'api_interface#swap_tops'
  get '/swap_pants', to: 'api_interface#swap_pants'
  get '/swap_shoes', to: 'api_interface#swap_shoes'
  get '/style', to: 'api_interface#style'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
