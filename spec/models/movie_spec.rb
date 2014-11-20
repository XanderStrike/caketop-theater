require 'rails_helper'

RSpec.describe Movie, :type => :model do
  describe '#poster' do
    it 'should return the path to the poster' do
      movie = build(:movie)
      expect(movie.poster).to eq("/posters/#{movie.id}.jpg")
    end
  end

  describe '#backdrop' do
    it 'should return the path to the packdrop' do
      movie = build(:movie)
      expect(movie.backdrop).to eq("/backdrops/#{movie.id}.jpg")
    end
  end
end
