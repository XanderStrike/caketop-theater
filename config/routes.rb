CaketopTheater::Application.routes.draw do
  get '/', to: 'home#index'
  get '/theater', to: 'home#index'
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
end
