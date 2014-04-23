class Song < ActiveRecord::Base
  attr_accessible :title, :filename, :track
  belongs_to :album
end
