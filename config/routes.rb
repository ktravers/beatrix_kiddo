Rails.application.routes.draw do

  # Static Pages
  root 'pages#welcome'
  get 'info/where-to-stay' => 'pages#accomodations', as: :accomodations
  get 'info/travel' => 'pages#travel', as: :travel
  get 'info/registry' => 'pages#registry', as: :registry
  get 'about' => 'pages#about', as: :about
  get 'trivia' => 'pages#trivia', as: :trivia

  # Sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  post 'sessions' => 'sessions#create'

  # Events
  get '/events' => 'events#index'
  get '/events/:event_slug' => 'events#show'
  get '/events/:event_slug/admin' => 'events#dashboard'

  # Rsvps
  resources :rsvps, only: [:update]

  # Plus Ones
  resources :plus_ones, only: [:update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
