class Genre < ActiveRecord::Base
  attr_accessible :id, :genre_id, :movie_id, :name

  validates :genre_id, uniqueness: { scope: [:movie_id] }

  belongs_to :movie
end
