Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "stations#index"

  resources :stations, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :bookings, only: [:create]
  end
  
  resources :users, only: [:show, :update] do
    resources :vehicles, only: [:new, :create, :edit, :update] # Ressources des véhicules
  end

  get '/leaderboard', to: 'users#leaderboard'
  resources :vehicles, only: [:edit, :update, :destroy, :new, :create]

  resources :bookings, only: [:index, :show, :edit, :update, :destroy] do

    resources :conflicts, only: [:new, :create]
    resources :messages, only: [:create] # Ressource des messages
    member do
      patch :submit_offer
      patch :accept_offer
      patch :reject_offer
      patch :start_charge
      patch :stop_charge
      patch :validate_payment
    end
  end

  resources :vehicles do
    get 'get_models_by_brand', on: :collection
  end


  resources :badges, only: [:create, :destroy]

  get '/wheel', to: 'wheels#index'

  post '/start_reservation', to: 'reservations#start_reservation'
  post '/accept_offer', to: 'reservations#accept_offer'
  post '/reject_offer', to: 'reservations#reject_offer'
  post '/start_charging', to: 'reservations#start_charging'
  post '/stop_charging', to: 'reservations#stop_charging'

end
