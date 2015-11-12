class Movie < ActiveRecord::Base
  SORT_ORDERS = [
    ['Title (asc)', 'title asc'],
    ['Title (desc)', 'title desc'],
    ['Release Date (asc)', 'release_date asc'],
    ['Release Date (desc)', 'release_date desc'],
    ['Runtime (asc)', 'runtime asc'],
    ['Runtime (desc)', 'runtime desc'],
    ['TMDB Rating (asc)', 'vote_average asc'],
    ['TMDB Rating (desc)', 'vote_average desc'],
    ['Revenue (asc)', 'revenue asc'],
    ['Revenue (desc)', 'revenue desc'],
    ['Added (asc)', 'added asc'],
    ['Added (desc)', 'added desc']
  ]

  has_many :genres

  has_many :encodes

  has_many :comments

  has_many :views

  def poster
    "/posters/#{id}.jpg"
  end

  def backdrop
    "/backdrops/#{id}.jpg"
  end

  def watch
    views.create
  end

  def filename
    encodes.first.filename
  end
end
