# frozen_string_literal: true
class Show < ActiveRecord::Base
  has_many :genres, foreign_key: :movie_id

  def poster
    "/posters/tv_#{id}.jpg"
  end

  def backdrop
    "/backdrops/tv_#{id}.jpg"
  end
end
