class Movie < ActiveRecord::Base
  attr_accessible :added, :backdrop_path, :budget, :filename, :id, :imdb_id, :original_title, :overview, :popularity, :poster_path, :release_date, :revenue, :runtime, :status, :tagline, :title, :vote_average, :vote_count
end
