class Artist < ActiveRecord::Base
  attr_accessible :name

  has_many :albums
  has_many :songs, through: :albums
end
