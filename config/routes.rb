CaketopTheater::Application.routes.draw do
  root to: 'home#index'
  get '/theater', to: 'home#index'
  get '/about', to: 'home#about'

  get '/settings', to: 'home#settings'
  post '/settings', to: 'home#settings'

  resources :genres, only: [:show]



  post 'movies/search'
  get 'movies/shuffle'
  post 'movies/browse'
  get 'movies/browse'
  resources :movies, only: [:index, :show]

  post 'encodes/find_movie'
  get 'encodes/retag'

  post 'shows/search'
  resources :shows, only: [:index, :show]

  resources :feedbacks, only: [:index, :create, :show, :destroy]
  resources :requests, only: [:index, :create, :show, :destroy]

  get 'music/artist/:id', to: 'music#artist', as: :music_artist
  resources :music
end
