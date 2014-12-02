require 'rails_helper'


RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    before(:each) do
      create_settings
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "gathers and paginates the most recent comments" do
      expect(Comment).to receive_message_chain("where.order.page.per")
      get :index
    end
  end

  describe "GET about" do
    it "renders the about template" do
      create_settings
      get :about
      expect(response).to render_template("about")
    end
  end

  describe "GET settings" do
    it "renders the settings template" do
      create_settings
      get :settings
      expect(response).to render_template("settings")
    end

    context "first visit" do
      it "creates new settings" do
        expect(Setting.count).to eq(0)
        get :settings, first_time: 'true'
        expect(Setting.count).to_not eq(0)
      end
    end

    context "subsequent visits" do
      before(:each) do
        create_settings
      end

      it "does not create additional settings" do
        count = Setting.count
        get :settings
        expect(Setting.count).to eq(count)
      end
    end
  end

  describe "POST settings" do
    before(:each) do
      create_settings
    end

    it "updates the name" do
      post :settings, setting: 'name', name_text: 'A New Name'
      expect(Setting.get('name').content).to eq('A New Name')
    end

    it "updates the about page" do
      post :settings, setting: 'about', about_text: 'A new about page'
      expect(Setting.get('about').content).to eq('A new about page')
    end

    it "updates the banner" do
      post :settings, setting: 'banner', banner_text: 'A new banner', banner_display: 'true'
      expect(Setting.get('banner').content).to eq('A new banner')
      expect(Setting.get('banner').boolean).to be_truthy
    end

    it "updates the footer" do
      post :settings, setting: 'footer', footer_text: 'A new footer', footer_display: 'true'
      expect(Setting.get('footer').content).to eq('A new footer')
      expect(Setting.get('footer').boolean).to be_truthy
    end

    it "updates the admin account" do
      post :settings, setting: 'admin', admin_username: 'xanderstrike', protect: 'true', admin_pass: 'password'
      expect(Setting.get('admin').content).to eq('xanderstrike')
      expect(Setting.get('admin').boolean).to be_truthy
      expect(Setting.get('admin-pass').content).to eq(Digest::SHA256.hexdigest('password'))
    end
  end

  describe ".authenticate" do
    
  end
end
