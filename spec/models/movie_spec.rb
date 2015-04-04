require 'rails_helper'

RSpec.describe Movie, :type => :model do
  context 'with non persisted movie' do
    let(:movie) { build(:movie) }
    describe '#poster' do
      it 'should return the path to the poster' do
        expect(movie.poster).to eq("/posters/#{movie.id}.jpg")
      end
    end

    describe '#backdrop' do
      it 'should return the path to the packdrop' do
        expect(movie.backdrop).to eq("/backdrops/#{movie.id}.jpg")
      end
    end
  end

  context 'with persisted movie' do
    let(:movie) { create(:movie) }
    describe '#watch' do
      it 'should add one to the movies watches' do
        movie = create(:movie)
        count = movie.views.count
        movie.watch
        expect(movie.views.count).to eq(count + 1)
      end
    end
  end
  describe '#filename' do
    it 'returns the filename' do
      movie_with_encodes = create(:movie_with_encode)
      expect(movie_with_encodes.filename).to match(/Movie/)
    end
  end
end
