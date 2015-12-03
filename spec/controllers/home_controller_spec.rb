# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    before(:each) do
      create_settings
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'gathers and paginates the most recent comments' do
      create_list(:comment, 10, movie_id: 0)
      get :index
      expect(assigns(:comments).first).to be_a(Comment)
      expect(assigns(:comments).size).to eq(10)
    end
  end

  describe 'GET charts' do
    before(:each) do
      create_settings
    end

    it 'renders the charts template' do
      get :charts
      expect(response).to render_template('charts')
    end

    it 'gathers the information needed in the charts' do
      create_list(:movie_with_views, 100)
      get :charts
      expect(assigns(:top_movies)).to_not be(nil)
      expect(assigns(:views_by_day)).to_not be(nil)
      expect(assigns(:tv_eps)).to_not be(nil)
      expect(assigns(:views_by_hour)).to_not be(nil)
      expect(assigns(:views_by_day_of_week)).to_not be(nil)
      expect(assigns(:genre_views)).to_not be(nil)
      expect(assigns(:movies_per_genre)).to_not be(nil)
    end
  end

  describe 'GET about' do
    it 'renders the about template' do
      create_settings
      get :about
      expect(response).to render_template('about')
    end
  end
end
