class Genre < ActiveRecord::Base
  attr_accessible :id, :movie_id, :name
end
