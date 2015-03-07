class Genre < ActiveRecord::Base
  attr_accessible :id, :genre_id, :movie_id, :name

  validates_uniqueness_of :genre_id, scope: :movie_id

  belongs_to :movie
end
