require 'rails_helper'

RSpec.describe MusicController, type: :controller do
  before(:each) do
    create_settings
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('music/index.html')
    end

    it 'displays the all the artists' do
      create_list(:artist, 30)
      get :index
      expect(assigns(:artists).first).to be_a(Artist)
      expect(assigns(:artists).count).to be(30)
      expect(assigns(:limited_artists).count).to eq(assigns(:page_size))
    end

    it 'filters on artist name' do
      create_list(:artist, 30)
      artist = create(:artist, name: 'The Bloody Beetroots')
      get :index, artist: 'beet'
      expect(assigns(:artists).first).to eq(artist)
    end

    it 'paginates' do
      create_list(:artist, 50)
      get :index, page: 1
      expect(assigns(:limited_artists).first).to eq(Artist.order('name asc').offset(assigns(:page_size)).first)
    end
  end

  describe 'GET artist' do
    it 'renders the index template' do
      get :artist, id: 1
      expect(response).to render_template('music/index.html')
    end

    it 'picks the correct artist' do
      artist = create(:artist)
      get :artist, id: artist.id
      expect(assigns(:artist)).to eq(artist)
    end
  end
end
