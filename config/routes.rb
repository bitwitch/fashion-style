Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get '/welcome', to: 'sessions#welcome'
  root to: 'sessions#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
