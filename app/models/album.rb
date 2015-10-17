class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs
end
