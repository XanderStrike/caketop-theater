class Show < ActiveRecord::Base
  has_many :genres, foreign_key: :movie_id

  def poster
    "/posters/tv_#{self.id}.jpg"
  end

  def backdrop
    "/backdrops/tv_#{self.id}.jpg"
  end
end
