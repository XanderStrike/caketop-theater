class HomeController < ApplicationController
  before_filter :authenticate, only: :settings

  NilMovie = Struct.new(:title)
  NilGenre = Struct.new(:name)

  def index
    @comments = Comment.where(movie_id: 0).order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.js { render 'comments/index' }
    end
  end

  def charts
    @top_movies = top_movies

    @views_by_day = views_by_day

    @tv_eps = `find public/tv/* | wc -l`.to_i

    @views_by_hour = View.where('').group_by(&:hour).map { |k, views| [k.to_i, views.count]}.sort
    @views_by_day_of_week = View.where('').group_by(&:day_of_week).sort.map { |k, views| [Date::DAYNAMES[k.to_i], views.count]}

    @genre_views = View.joins("JOIN genres ON genres.movie_id = views.movie_id").select("*").group("genres.name").count.sort { |a,b| b[1] <=> a[1] }

    @movies_per_genre = Genre.where('').group_by(&:name).map { |n, gs| [n, gs.count] }.sort {|a,b| b[1] <=> a[1]}
  end

  def about
  end

  private

  def top_movies
    View.group(:movie_id).count.sort {|a,b| b[1] <=> a[1]}[0..19].map { |id, val|
      movie = Movie.find_by_id(id) || NilMovie.new("Unknown")
      [movie.title, val]
    }
  end

  def views_by_day
    View.where('created_at > ?', 1.week.ago).group_by { |u|
      u.created_at.localtime.beginning_of_day
    }.reduce({}) { |h, (k,v)|
      h[k] = v.size; h
    }
  end
end
