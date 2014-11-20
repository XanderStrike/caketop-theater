require 'rails_helper'

RSpec.describe 'Artist Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'artist' do
    it 'creates an artist with a name' do
      artist = build(:artist)
      expect(artist.name).to_not eq(nil)
    end
  end

  describe 'artist_with_albums' do
    it 'creates an artist with a name and albums' do
      artist = create(:artist_with_albums)
      expect(artist.name).to_not eq(nil)
      expect(artist.albums.count).to eq(5)
    end
  end

  describe 'artist_with_albums_and_songs' do
    it 'creates an artist with a name and albums and songs' do
      artist = create(:artist_with_albums_and_songs)
      expect(artist.name).to_not eq(nil)
      expect(artist.albums.count).to eq(5)
      expect(artist.albums.first.songs.first.title).to_not eq(nil)
    end
  end

  it 'has all the attributes from the model' do
    expect(attributes_for(:artist)).to include(*(factory_attributes(Artist)))
  end

  it 'produces a valid model' do
    expect(build(:artist)).to be_valid
  end
end
