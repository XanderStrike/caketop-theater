class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @new = Movie.order('added desc').limit(12)
    @discussed = Comment.where("movie_id > ?", 0).order('id desc').limit(20).map(&:movie).uniq[0..5]

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
    @comments = @movie.comments.order(:id).page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
      format.js { render 'comments/index' }
    end
  end

  def browse
    # movie filters
    @movies = Movie.where("title like ?", "%#{params[:title]}%")
    @movies = @movies.where("overview like ?", "%#{params[:desc]}%") unless params[:desc].blank?
    @movies = @movies.where("runtime > ?", params[:runtime_min]) unless params[:runtime_min].blank?
    @movies = @movies.where("runtime < ?", params[:runtime_max]) unless params[:runtime_max].blank?
    @movies = @movies.where("revenue > ?", params[:revenue_min]) unless params[:revenue_min].blank?
    @movies = @movies.where("revenue < ?", params[:revenue_max]) unless params[:revenue_max].blank?
    @movies = @movies.where("budget > ?", params[:budget_min]) unless params[:budget_min].blank?
    @movies = @movies.where("budget < ?", params[:budget_max]) unless params[:budget_max].blank?
    @movies = @movies.where("vote_average > ?", params[:vote_average_min]) unless params[:vote_average_min].blank?
    @movies = @movies.where("vote_average < ?", params[:vote_average_max]) unless params[:vote_average_max].blank?

    # encode filters
    @movies = @movies.where('encodes.filename like ?', "%#{params[:filename]}%").includes(:encodes) unless params[:filename].blank?
    @movies = @movies.where('encodes.container = ?', "#{params[:container]}").includes(:encodes) unless params[:container].blank?
    @movies = @movies.where('encodes.a_format = ?', "#{params[:a_format]}").includes(:encodes) unless params[:a_format].blank?
    @movies = @movies.where('encodes.v_format = ?', "#{params[:v_format]}").includes(:encodes) unless params[:v_format].blank?
    @movies = @movies.where('encodes.resolution = ?', "#{params[:resolution]}").includes(:encodes) unless params[:resolution].blank?

    # genre, includes doesn't work so we do it the hard way
    @movies = @movies.where(id: Genre.where(id: params[:genre]).map(&:movie_id)) unless params[:genre].blank?

    # sort
    @movies = @movies.order((params[:sort] || 'title asc'))

    @page_size = 24
    @limited_movies = @movies.limit(@page_size).offset(@page_size * params[:page].to_i)

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @movies }
    end
  end

  def search
    @results = Movie.search(params[:q], fields: ["title^10", "original_title^10", "tagline", "overview"])
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
