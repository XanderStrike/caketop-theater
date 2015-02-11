require 'rails_helper'

RSpec.describe 'Movie Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe "movie" do
    it 'has all the attributes from the model' do
      expect(attributes_for(:movie)).to include(*(factory_attributes(Movie)))
    end

    it 'produces a valid model' do
      expect(build(:movie)).to be_valid
    end

    it 'has genres' do
      expect(create(:movie).genres.count).to eq(3)
    end

    it 'has encodes' do
      expect(create(:movie).encodes.count).to eq(2)
    end
  end

  describe "movie_with_comments" do
    it "has some comments" do
      expect(create(:movie_with_comments).comments.count).to eq(50)
    end
  end

  describe "movie_with_views" do
    it "has some views" do
      expect(create(:movie_with_views).views.count).to_not eq(0)
    end
  end
end
