class Genre < ActiveRecord::Base
  attr_accessible :id, :genre_id, :movie_id, :name

  validates :genre_id, uniqueness: { scope: [:movie_id] }

  belongs_to :movie

  def self.movies_per
    where('').group_by(&:name).map { |n, gs| [n, gs.count] }.sort {|a,b| b[1] <=> a[1]}
  end
end
