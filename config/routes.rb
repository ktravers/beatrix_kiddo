Rails.application.routes.draw do

  # Static Pages
  root 'pages#welcome'

  # Sessions
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  post 'sessions' => 'sessions#create'
  get 'reset_password' => 'sessions#reset_password'
  post 'send_password' => 'sessions#send_password'

  # Users
  get 'signup' => 'users#new', :as => 'signup'

  # Event Pages
  get '/events' => 'events#index' # TODO
  get '/events/:event_slug' => 'events#show'

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
