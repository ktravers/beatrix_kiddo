Rails.application.routes.draw do

  # Static Pages
  root 'pages#welcome'

  # Sessions
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  post 'sessions' => 'sessions#create'
  post 'send-password' => 'sessions#send_password'
  get 'reset-password' => 'sessions#reset_password'

  # Event Pages
  get '/events/:event_slug' => 'events#show'

  # Users
  resources :users, only: [:new, :create, :edit, :update]
  get 'signup' => 'users#new', :as => 'signup'

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
