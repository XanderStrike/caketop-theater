class Show < ActiveRecord::Base
  attr_accessible :backdrop_path, :first_air_date, :folder, :id, :name, :original_name, :overview, :popularity, :poster_path, :vote_average, :vote_count
end
