class Movie < ActiveRecord::Base
  attr_accessible :added, :backdrop_path, :budget, :id, :imdb_id, :original_title, :overview, :popularity, :poster_path, :release_date, :revenue, :runtime, :status, :tagline, :title, :vote_average, :vote_count

  has_many :genres, dependent: :destroy

  has_many :encodes

  has_many :comments, dependent: :destroy

  has_many :views, dependent: :destroy

  def poster
    "/posters/#{self.id}.jpg"
  end

  def backdrop
    "/backdrops/#{self.id}.jpg"
  end

  def self.sort_orders
    [
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
      ['Added (desc)', 'added desc'],
    ]

  end

  def watch
    self.views.create
  end

  def filename
    self.encodes.first.filename
  end

end
