class GenresController < ApplicationController
  # GET /genres
  # GET /genres.json
  def index
    @genres = Genre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @genres }
    end
  end

  # GET /genres/1
  # GET /genres/1.json
  def show
    @genre = Genre.where(id: params[:id]).first
    @movies = Movie.where(id: Genre.where(id: params[:id]).map(&:movie_id))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @genre }
    end
  end
end
