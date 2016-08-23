Rails.application.routes.draw do

  # Static Pages
  root 'pages#welcome'

  # Sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  post 'sessions' => 'sessions#create'

  # Users
  resources :users, only: [:create, :edit, :update]
  get 'register' => 'users#new', as: :register
  get 'reset-password' => 'users#reset_password', as: :reset_password
  post 'send-password' => 'users#send_password',  as: :send_password

  # Event Pages
  get '/events/:event_slug' => 'events#show'

  namespace :api do
    # Rsvps
    resources :rsvps, only: [:edit, :update]
  end

  # TODO: add general info pages
  # Registry
  # Accomodations
  #   - Hotels
  #   - Airbnbs
  # Travel / Getting Around
  #   - Airports
  #   - Car Services
  #   - Subway / LIRR info
  #   - Map with venues identified
end
