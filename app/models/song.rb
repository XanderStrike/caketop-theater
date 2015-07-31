class Song < ActiveRecord::Base
  attr_accessible :title, :filename, :track
  belongs_to :album
  has_one :artist, through: :album
end
