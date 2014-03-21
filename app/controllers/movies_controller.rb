class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @new = Movie.order('added desc').limit(12)
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  def search
    @results = Movie.where("title like ?", "%#{params[:q]}%")
    @results += Movie.where("original_title like ?", "%#{params[:q]}%")
    @results += Movie.where("filename like ?", "%#{params[:q]}%")
    @results += Movie.where("overview like ?", "%#{params[:q]}%")
    @results = @results.uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @results }
    end
  end

  def shuffle
    @random = Movie.order('random()').limit(6)
  end
end
