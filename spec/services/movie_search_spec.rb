require 'rails_helper'

RSpec.describe MovieSearch, type: :model do
  describe '.simple_search' do
    it 'should filter a list of movies' do
      movies = create_list(:movie, 40)
      patton = create(:movie, title: 'Patton')
      potempkin = create(:movie, original_title: 'Battleship Potempkin')
      ryan = create(:movie, overview: 'Saving Private Ryan')

      expect(MovieSearch.simple_search('patton')).to eq([patton])
      expect(MovieSearch.simple_search('potempkin')).to eq([potempkin])
      expect(MovieSearch.simple_search('ryan')).to eq([ryan])
    end
  end

  describe '.initialize' do
    before(:each) do
      @movies = create_list(:movie, 40)
    end

    it 'has a list of movies' do
      search = MovieSearch.new({})

      expect(search.results.sort).to eq(@movies.sort)
    end

    it 'filters movie title, overview, and filename on the params it is passed' do
      movie = create(:movie, title: 'Vanishing Point')
      search = MovieSearch.new(title: 'vanishing')
      expect(search.results.first).to eq(movie)

      movie = create(:movie, overview: 'Bullitt')
      search = MovieSearch.new(overview: 'bull')
      expect(search.results.first).to eq(movie)

      movie = create(:encode, filename: 'The.Italian.Job.1969.1080p.mp4').movie
      search = MovieSearch.new(filename: '1969')
      expect(search.results.first).to eq(movie)
    end

    it 'applies a range to specific attributes' do
      movie = create(:movie, runtime: 100)
      short_movie = create(:movie, runtime: 30)
      long_movie = create(:movie, runtime: 120)
      search = MovieSearch.new(runtime_max: 110)
      expect(search.results).to include(movie)
      expect(search.results).to include(short_movie)
      expect(search.results).to_not include(long_movie)

      movie = create(:movie, runtime: 100)
      short_movie = create(:movie, runtime: 30)
      long_movie = create(:movie, runtime: 120)
      search = MovieSearch.new(runtime_min: 75)
      expect(search.results).to include(movie)
      expect(search.results).to include(long_movie)
      expect(search.results).to_not include(short_movie)

      movie = create(:movie, runtime: 100)
      short_movie = create(:movie, runtime: 30)
      long_movie = create(:movie, runtime: 120)
      search = MovieSearch.new(runtime_max: 110, runtime_min: 75)
      expect(search.results).to include(movie)
      expect(search.results).to_not include(short_movie)
      expect(search.results).to_not include(long_movie)
    end

    it 'filters on encodes attributes' do
      movie = create(:encode, container: 'mp4', a_format: 'AAC', v_format: 'AVC', resolution: '1080').movie

      search = MovieSearch.new(container: 'mp4')
      expect(search.results).to include(movie)

      search = MovieSearch.new(a_format: 'AAC')
      expect(search.results).to include(movie)

      search = MovieSearch.new(v_format: 'AVC')
      expect(search.results).to include(movie)

      search = MovieSearch.new(resolution: '1080')
      expect(search.results).to include(movie)
    end

    it 'filters on genre' do
      movie = create(:movie)
      search = MovieSearch.new(genre: movie.genres.first.genre_id)
      expect(search.results).to include(movie)
    end

    it 'sorts the results' do
      search = MovieSearch.new(sort: 'title desc')
      expect(search.results).to eq(Movie.order('title desc'))

      search = MovieSearch.new(sort: 'vote_average asc')
      expect(search.results).to eq(Movie.order('vote_average asc'))
    end
  end
end
