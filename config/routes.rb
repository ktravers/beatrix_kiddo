Rails.application.routes.draw do

  # Static Pages
  root 'pages#show'
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

  # Event Pages
  get '/events' => 'events#index' # TODO
  get '/events/:event_slug' => 'events#show'

end
