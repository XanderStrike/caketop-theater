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

  describe '#watch' do
    it 'should add one to the movies watches' do
      movie = create(:movie)
      count = movie.views.count
      movie.watch
      expect(movie.views.count).to eq(count + 1)
    end
  end

  it 'should delete comments on destroy' do
    movie = create_list(:movie_with_comments, 5)
    expect { movie.first.destroy }.to change { Comment.count }.by(-50)
  end

  it 'should delete views on destroy' do
    movie = create_list(:movie_with_views, 5)
    expect { movie.first.destroy }.to change { View.count }.by(-movie.first.views.count)
  end

  it 'should delete genres on destroy' do
    movie = create_list(:movie, 5).first
    expect { movie.destroy }.to change { Genre.count }.by(-movie.genres.count)
  end
end
