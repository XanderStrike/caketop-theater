class Song < ActiveRecord::Base
  attr_accessible :title, :filepath, :filename, :track
  belongs_to :album
end
