require 'rails_helper'

RSpec.describe Movie, :type => :model do
  describe '#poster' do
    it 'should return the path to the poster' do
      movie = Movie.new(id: 1234)
      expect(movie.poster).to eq('/posters/1234.jpg')
    end
  end

  describe '#backdrop' do
    it 'should return the path to the packdrop' do
      movie = Movie.new(id: 1234)
      expect(movie.backdrop).to eq('/backdrops/1234.jpg')
    end
  end
end
