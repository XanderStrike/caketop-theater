require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'validations' do
    it 'should enforce uniqueness on genre_id with scope movie_is' do
      genre = create(:genre)
      invalid_genre = build(:genre, genre_id: genre.genre_id, movie_id: genre.movie_id)

      expect(invalid_genre.valid?).to be_falsey
      expect(invalid_genre.errors.messages).to eq(genre_id: ['has already been taken'])
    end
  end
end
