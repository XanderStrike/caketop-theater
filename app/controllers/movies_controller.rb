class MoviesController < ApplicationController
  include SearchHelper
  # GET /movies
  # GET /movies.json

  SEARCHABLE_FIELDS = %w(title original_title overview)

  def index
    @movies = Movie.all
    @new = Movie.order('added desc').limit(12)
    @discussed = Comment.where("movie_id > ?", 0).order('id desc').limit(20).map(&:movie).uniq[0..5].compact

    @viewed = View.where("created_at >= ?", Time.now - 1.day)
                    .group(:movie_id).count.sort {|a,b| b[1] <=> a[1]}.map {|a| a[0]}.first(6)
                    .map {|id| Movie.find(id)}

    @random = Movie.order('random()').limit(6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
      format.js { render 'comments/index' }
    end
  end

  def browse
    @movies = MovieSearch.new(params).results
    @page_size = 24
    @limited_movies = @movies.limit(@page_size).offset(@page_size * params[:page].to_i)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @movies }
    end
  end

  def search
    @results = model_search(Movie, SEARCHABLE_FIELDS, params[:q])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @results }
    end
  end

  def shuffle
    @random = Movie.order('random()').limit(6)
  end

  def watch
    Movie.find(params[:id]).watch
    render nothing: true
  end
end
