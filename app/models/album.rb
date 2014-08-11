class Album < ActiveRecord::Base
  attr_accessible :name, :art, :year, :genre
  belongs_to :artist
  has_many :songs
end
