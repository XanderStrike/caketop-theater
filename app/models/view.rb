class View < ActiveRecord::Base
  attr_accessible :movie_id, :time

  belongs_to :movie
end
