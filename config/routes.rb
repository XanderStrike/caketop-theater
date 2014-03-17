CaketopTheater::Application.routes.draw do

  resources :shows


  get '/', to: 'home#index'
  get '/theater', to: 'home#index'

  resources :genres
  
  post 'movies/search'
  get 'movies/shuffle'
  resources :movies

  post 'encodes/find_movie'
  get 'encodes/retag'
end
