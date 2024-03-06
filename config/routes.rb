Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "stations#index"

  resources :stations, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:create]
  end

  resources :users, only: [:show, :update] do
    resources :vehicles, only: [:new, :create] # Ressources des véhicules
  end

  resources :vehicles, only: [:edit, :update, :destroy] # Correction de la ressource des véhicules

  resources :bookings, only: [:index, :show, :edit, :update] do
    resources :conflicts, only: [:new, :create]
    resources :messages, only: [:create] # Ressource des messages
  end

  resources :badges, only: [:create]

  post '/start_reservation', to: 'reservations#start_reservation'
  post '/accept_offer', to: 'reservations#accept_offer'
  post '/reject_offer', to: 'reservations#reject_offer'
  post '/start_charging', to: 'reservations#start_charging'
  post '/stop_charging', to: 'reservations#stop_charging'
end
# Les belles routes
