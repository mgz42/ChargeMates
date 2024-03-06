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
    resources :vehicles, only: [:new, :create]
  end

  resources :vehicles, only: [:edit, :update, :destroy]
  resources :bookings, only: [:index, :show, :edit, :update] do
    resources :conflicts, only: [:new, :create]
    resources :messages, only: [:create]
  end

  resources :badges, only: [:create]
end
# Les belles routes
