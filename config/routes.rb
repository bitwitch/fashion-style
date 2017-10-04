Rails.application.routes.draw do
  resources :outfits, only: [:new, :create, :show, :destroy, :index]
  resources :users
  resources :sessions, only: [:new, :create]

  root to: 'sessions#welcome'
  get '/welcome', to: 'sessions#welcome'
  get '/browse', to: 'users#browse'
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
  get '/page', to: 'api_interface#page'
  get '/profile', to: 'users#profile'
  get '/add_friend', to: 'users#add_friend'
  get '/my_friends', to: 'users#my_friends'
  get '/all_outfits', to: 'outfits#all_outfits'
  get '/like_outfit', to: 'outfits#like_outfit'
  get '/view_likes', to: 'outfits#view_likes'
  get '/unfriend', to: 'users#unfriend'
  get '/outfits_i_like', to: 'outfits#outfits_i_like'
  get '/unlike', to: 'outfits#unlike'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
