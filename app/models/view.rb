class View < ActiveRecord::Base
  attr_accessible :movie_id, :created_at

  belongs_to :movie
end
