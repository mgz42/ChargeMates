Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root to: "stations#index"

  resources :stations, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:create]
  end

  resources :users, only: [:show, :update] do
    resources :vehicles, only: [:new, :create, :edit, :update] # Ressources des véhicules
  end

  get '/leaderboard', to: 'users#leaderboard'
  resources :vehicles, only: [:edit, :update, :destroy, :new, :create]

  resources :bookings, only: [:index, :show, :update] do
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

  resources :badges, only: [:create]
end
