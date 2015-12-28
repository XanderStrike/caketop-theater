# frozen_string_literal: true
CaketopTheater::Application.routes.draw do
  resources :comments, only: [:index, :create]
  resources :pages

  get '/', to: 'home#index'
  get '/theater', to: 'home#index'
  get '/about', to: 'home#about'
  get '/stats', to: 'home#charts'

  get '/settings', to: 'settings#index'
  post '/settings', to: 'settings#index'

  resources :genres

  post 'movies/search'
  get 'movies/shuffle'
  post 'movies/browse'
  get 'movies/browse'
  get 'movies/watch/:id', to: 'movies#watch'
  resources :movies

  post 'encodes/find_movie'
  get 'encodes/retag'

  post 'shows/search'
  resources :shows

  get 'music/artist/:id', to: 'music#artist', as: :music_artist
  resources :music, as: :songs

  root to: 'home#index'
end
