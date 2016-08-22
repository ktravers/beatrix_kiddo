Rails.application.routes.draw do

  # Static Pages
  root 'pages#show'
  # TODO: add general info pages

  # Event Pages
  get '/events' => 'events#index' # TODO
  get '/events/:event_slug' => 'events#show'

end
