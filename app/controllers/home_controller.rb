class HomeController < ApplicationController
  before_filter :authenticate, only: :settings

  def index
    @comments = Comment.where(movie_id: 0).order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.js { render 'comments/index' }
    end
  end

  def charts
    @top_movies = View.top_movies(20)
    @genre_views = View.genre_views
    @views_by_day = View.by_day(1.week)
    @views_by_hour = View.by_hour
    @views_by_day_of_week = View.by_day_of_week
    @tv_eps = `find public/tv/* | wc -l`.to_i
    @movies_per_genre = Genre.movies_per
  end

  def about
  end
end
