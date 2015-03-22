class View < ActiveRecord::Base
  attr_accessible :movie_id, :created_at

  belongs_to :movie

  NilMovie = Struct.new(:title)

  def self.top_movies(limit)
    group(:movie_id).count.sort { |a,b| b[1] <=> a[1]}[0...limit].map { |id, val|
      movie = Movie.find_by_id(id) || NilMovie.new("Unknown")
      [movie.title, val]
    }
  end

  def self.genre_views
    joins("JOIN genres ON genres.movie_id = views.movie_id").select("*").group("genres.name").count.sort { |a,b|
      b[1] <=> a[1]
    }
  end
  
  def self.by_day_of_week
    # when rails 4 convert to select_all and move to View model
    # i.e. select_all("strftime('%w', created_at), count(*)").group("strftime('%w', created_at)")
    where('').group_by(&:day_of_week).sort.map { |k, views| [Date::DAYNAMES[k.to_i], views.count]}
  end

  def self.by_day(period)
    where('created_at > ?', period.ago).group_by { |u|
      u.created_at.localtime.beginning_of_day
    }.reduce({}) { |h, (k,v)|
      h[k] = v.size; h
    }
  end

  def self.by_hour
    where('').group_by(&:hour).map { |k, views| [k.to_i, views.count]}.sort
  end

  
  
  def hour
    self.created_at.localtime.strftime('%H')
  end

  def day_of_week
    self.created_at.localtime.strftime('%w')
  end
end
