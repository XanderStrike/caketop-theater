class Show < ActiveRecord::Base
  searchkick

  attr_accessible :backdrop_path, :first_air_date, :folder, :id, :name, :original_name, :overview, :popularity, :poster_path, :vote_average, :vote_count

  has_many :genres

  def poster
    "/posters/tv_#{self.id}.jpg"
  end

  def backdrop
    "/backdrops/tv_#{self.id}.jpg"
  end
end
