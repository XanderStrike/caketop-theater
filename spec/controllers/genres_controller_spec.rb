require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  before(:each) do
    create_settings
  end

  describe 'GET show' do
    it 'runs the show method and renders the show partial' do
      expect(controller).to receive(:show)
      get :show, id: 1
      expect(response).to render_template(:show)
    end

    it 'gets the genre and the movies attached to it' do
      create(:genre)
      get :show, id: Genre.first.id
      expect(assigns(:genre)).to be_a(Genre)
      expect(assigns(:movies).first).to be_a(Movie)
    end
  end
end
