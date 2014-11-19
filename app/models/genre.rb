class Genre < ActiveRecord::Base
  attr_accessible :id, :movie_id, :name

  belongs_to :movie
end
