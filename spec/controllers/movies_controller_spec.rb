require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
	before(:each) do
    create_settings
  end

  describe 'GET index' do
  	it 'renders the index template' do
  		get :index
  		expect(response).to render_template(:index)
  	end

  	it 'gathers the information needed for the movie home page' do
			create_list(:movie_with_views, 10)
  		get :index
  		expect(assigns(:movies).first).to be_a(Movie)
  		expect(assigns(:new).first).to be_a(Movie)
  		expect(assigns(:viewed).first).to be_a(Movie)
  		expect(assigns(:random).first).to be_a(Movie)
  	end
  end

  describe 'GET show' do
  	it 'renders the show template' do
  		movie = create(:movie)
  		get :show, id: movie.id
  		expect(response).to render_template(:show)
  	end

  	it 'gathers the information needed for the movie show page' do
  		movie = create(:movie_with_comments)
  		get :show, id: movie.id
  		expect(assigns(:movie)).to be_a(Movie)
  		expect(assigns(:movie).id).to eq(movie.id)
  		expect(assigns(:comments).first).to be_a(Comment)
  	end
  end

  describe 'GET browse' do
  	it 'renders the browse template' do
  		movies = create_list(:movie, 40)
  		get :browse
  		expect(response).to render_template(:browse)
  	end

  	it 'returns a list of movies of the right size' do
  		movies = create_list(:movie, 40)
  		get :browse
  		expect(assigns(:movies).first).to be_a(Movie)
  		expect(assigns(:limited_movies).first).to be_a(Movie)
  		expect(assigns(:limited_movies).size).to eq(assigns(:page_size))
  	end

  	#TODO test the rest ugh
  	it 'filters movies by title' do
  		create_list(:movie, 40)
  		create(:movie, title: 'Fury')
  		get :browse, title: 'Fury'
  		expect(assigns(:movies).first.title).to eq('Fury')
  	end
  end

  describe 'GET search' do
  	it 'renders the search template' do
  		movies = create_list(:movie, 40)
  		get :search, q: ''
  		expect(response).to render_template(:search)
  	end

  	it 'returns a list of movies' do
  		movies = create_list(:movie, 40)
  		get :search, q: ''
  		expect(assigns(:results).first).to be_a(Movie)
  	end

  	it 'filters on the query string' do
  		movies = create_list(:movie, 40)
  		create(:movie, title: 'Patton')

  		get :search, q: 'Patton'
  		expect(assigns(:results).first.title).to eq('Patton')
  	end
  end

  describe 'GET shuffle' do
  	#TODO js tests
  end

  describe 'GET watch' do
  	it 'adds a view for a movie' do
  		movie = create(:movie)
  		expect { get(:watch, id: movie.id) }.to change { View.count }.by(1 )
  	end
  end
end
