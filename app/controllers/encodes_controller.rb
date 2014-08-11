class EncodesController < ApplicationController
  def find_movie
    @encode = Encode.find(params[:id])
    @results = Tmdb::Movie.find(params[:title])
  end

  def retag
    encode = Encode.find(params[:id])
    info = Tmdb::Movie.detail(params[:movie_id])

    old_movie = Movie.find_by_id(encode.movie_id)

    `wget https://d3gtl9l2a4fn1j.cloudfront.net/t/p/w500/#{ info.poster_path } -O ./app/assets/images/posters/#{info.id}.jpg -b -q`
    `wget http://image.tmdb.org/t/p/w1000/#{ info.backdrop_path } -O ./app/assets/images/backdrops/#{info.id}.jpg -b -q`

    movie = Movie.find_by_id(info.id) || Movie.create(id: info.id)
    movie.backdrop_path = info.backdrop_path
    movie.backdrop_path = info.backdrop_path
    movie.budget = info.budget
    movie.id = info.id
    movie.imdb_id = info.imdb_id
    movie.original_title = info.original_title
    movie.overview = info.overview
    movie.popularity = info.popularity
    movie.poster_path = info.poster_path
    movie.release_date = info.release_date
    movie.revenue = info.revenue
    movie.runtime = info.runtime
    movie.status = info.status
    movie.tagline = info.tagline
    movie.title = info.title
    movie.vote_average = info.vote_average
    movie.vote_count = info.vote_count
    movie.added = Time.now.to_s
    movie.save

    unless Genre.where(movie_id: info.id).count > 0
      info.genres.each do |g|
        Genre.create(id: g['id'], name: g['name'], movie_id: info.id)
      end
    end

    encode.movie_id = movie.id
    encode.save

    old_movie.destroy if old_movie.encodes.count < 1

    redirect_to movie
  end
end
