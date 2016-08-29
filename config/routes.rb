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

  # Event Pages
  get '/events/:event_slug' => 'events#show'

  namespace :api do
    # Rsvps
    resources :rsvps, only: [:edit, :update]
  end
end
