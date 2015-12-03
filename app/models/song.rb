# frozen_string_literal: true
class Song < ActiveRecord::Base
  belongs_to :album
  has_one :artist, through: :album
end
