# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Album Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'album' do
    it 'creates an album with a name' do
      album = build(:album)
      expect(album.name).to_not eq(nil)
    end

    it 'has all the attributes from the model' do
      expect(attributes_for(:album)).to include(*(factory_attributes(Album) - [:artist_id]))
    end

    it 'produces a valid model' do
      expect(build(:album)).to be_valid
    end
  end

  describe 'album_with_songs' do
    it 'creates an album with songs' do
      album = create(:album_with_songs)
      expect(album.songs.count).to eq(10)
    end
  end
end
