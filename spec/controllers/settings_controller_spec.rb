require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      create_settings
      get :index
      expect(response).to render_template('index')
    end

    context 'first visit' do
      it 'creates new settings' do
        expect(Setting.count).to eq(0)
        get :index, first_time: 'true'
        expect(Setting.count).to_not eq(0)
      end

      it 'assigns default values to the settings' do
        expect(Setting.count).to eq(0)
      	get :index, first_time: 'true'
      	expect(assigns(:name).content).to eq('Caketop Theater')
      end
    end

    context 'subsequent visits' do
      before(:each) do
        create_settings
      end

      it 'does not create additional index' do
        count = Setting.count
        get :index
        expect(Setting.count).to eq(count)
      end
    end
  end

   describe 'POST index' do
    before(:each) do
      create_settings
    end

    it 'updates the name' do
      post :index, setting: 'name', content: 'A New Name'
      expect(Setting.get('name').content).to eq('A New Name')
    end

    it 'updates the about page' do
      post :index, setting: 'about', content: 'A new about page'
      expect(Setting.get('about').content).to eq('A new about page')
    end

    it 'updates the banner' do
      post :index, setting: 'banner', content: 'A new banner', boolean: 'true'
      expect(Setting.get('banner').content).to eq('A new banner')
      expect(Setting.get('banner').boolean).to be_truthy
    end

    it 'updates the footer' do
      post :index, setting: 'footer', content: 'A new footer', boolean: 'true'
      expect(Setting.get('footer').content).to eq('A new footer')
      expect(Setting.get('footer').boolean).to be_truthy
    end

    it 'updates the admin account' do
      post :index, setting: 'admin', content: 'xanderstrike', boolean: 'true', admin_pass: 'password'
      expect(Setting.get('admin').content).to eq('xanderstrike')
      expect(Setting.get('admin').boolean).to be_truthy
      expect(Setting.get('admin-pass').content).to eq(Digest::SHA256.hexdigest('password'))
    end

    it 'updates the url' do
    	post :index, setting: 'url', content: '/caketoptheater'
    	expect(Setting.get('url').content).to eq('/caketoptheater')
    end
  end
end
