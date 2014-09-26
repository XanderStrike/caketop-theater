class Comment < ActiveRecord::Base
  attr_accessible :body, :movie_id, :name

  belongs_to :movie
end
