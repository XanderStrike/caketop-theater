require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before(:each) do
    create_settings
    @page = create(:page)
  end

  describe 'GET show' do
    it 'renders the show template' do
      get :show, id: @page.id
      expect(response).to render_template(:show)
    end

    it 'loads up the right page content' do
      get :show, id: @page.id
      expect(assigns(:page)).to eq(@page.content)
    end
  end

  describe 'GET new' do
    it 'renders the edit template' do
      get :new
      expect(response).to render_template(:edit)
    end

    it 'makes a new page' do
      get :new
      expect(assigns(:page)).to be_a(Page)
    end
  end

  describe 'GET edit' do
    it 'renders the edit template' do
      get :edit, id: @page.id
      expect(response).to render_template(:edit)
    end

    it 'loads up the right page' do
      get :edit, id: @page.id
      expect(assigns(:page)).to eq(@page)
    end
  end

  describe 'PUT create' do
    let(:valid_attribtes) { attributes_for(:page) }

    it 'redirects to the settings page' do
      put :create, page: valid_attribtes
      expect(response).to redirect_to(settings_path)
    end

    it 'creates a new page' do
      expect { put :create, page: valid_attribtes }.to change { Page.count }.by(1)
    end
  end

  describe 'PUT create' do
    let(:valid_attribtes) { attributes_for(:page) }

    it 'redirects to the settings page' do
      put :update, id: @page, page: valid_attribtes
      expect(response).to redirect_to(settings_path)
    end

    it 'updates the page with new settings' do
      attributes = attributes_for(:page, name: 'A New Title')
      page = create(:page, name: 'An Old Title')
      put :update, id: page, page: attributes
      page = Page.find(page.id)
      expect(page.name).to eq('A New Title')
    end
  end

  describe 'DELETE destroy' do
    it 'redirects to the settings page' do
      delete :destroy, id: @page
      expect(response).to redirect_to(settings_path)
    end

    it 'destroys the record' do
      expect { delete :destroy, id: @page } .to change { Page.count }
    end
  end
end
