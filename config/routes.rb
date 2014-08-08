CaketopTheater::Application.routes.draw do
  get "page/show"

  get '/', to: 'home#index'
  get '/theater', to: 'home#index'
  get '/settings', to: 'home#settings'
  post '/settings', to: 'home#settings'
  get '/about', to: 'home#about'

  resources :genres

  post 'movies/search'
  get 'movies/shuffle'
  post 'movies/browse'
  get 'movies/browse'
  resources :movies

  post 'encodes/find_movie'
  get 'encodes/retag'

  post 'shows/search'
  resources :shows

  resources :requests

  get 'music/artist/:id', to: 'music#artist', as: :music_artist
  resources :music

  root to: 'home#index'
end
