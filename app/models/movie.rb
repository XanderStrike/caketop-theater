class Movie < ActiveRecord::Base
  attr_accessible :added, :backdrop_path, :budget, :filename, :id, :imdb_id, :original_title, :overview, :popularity, :poster_path, :release_date, :revenue, :runtime, :status, :tagline, :title, :vote_average, :vote_count

  has_many :genres

  has_many :encodes

  def poster
    "posters/#{self.id}.jpg"
  end

  def backdrop
    "backdrops/#{self.id}.jpg"
  end
end
