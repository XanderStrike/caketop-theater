require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
	before(:each) do
    create_settings
    @list = create_list(:show, 15)
    @show = create(:show)
  end

  describe 'GET index' do
  	it 'renders the index template' do
  		get :index
  		expect(response).to render_template(:index)
  	end

  	it 'displays all the shows' do
  		get :index
  		expect(assigns(:shows).first).to be_a(Show)
  		expect(assigns(:shows).count).to eq(16) 
  	end
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, id: @show.id
      expect(response).to render_template(:show)
    end

    it 'pulls up the right show and attempts to scan the directory' do
      get :show, id: @show.id
      expect(assigns(:show)).to eq(@show)
      expect(assigns(:files)).to eq([])
    end
  end

  describe 'GET search' do
    it 'renders the show template' do
      get :search, q: ''
      expect(response).to render_template(:search)
    end

    it 'filters shows appropriately' do
      show = create(:show, name: 'Stargate SG-1')
      get :search, q: 'gate'
      expect(assigns(:results)).to eq([show])

      show = create(:show, original_name: 'Farscape')
      get :search, q: 'scape'
      expect(assigns(:results)).to eq([show])

      show = create(:show, folder: 'Firefly')
      get :search, q: 'fly'
      expect(assigns(:results)).to eq([show])

      show = create(:show, overview: 'Almost Human')
      get :search, q: 'human'
      expect(assigns(:results)).to eq([show])
    end
  end
end
