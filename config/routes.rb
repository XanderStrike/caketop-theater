CaketopTheater::Application.routes.draw do

  get '/', to: 'home#index'
  get '/theater', to: 'home#index'

  resources :genres
  
  resources :movies
  post 'movies/search'

end
