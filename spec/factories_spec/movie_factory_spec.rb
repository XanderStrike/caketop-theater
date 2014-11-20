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

  def factory_attributes(klass)
    klass.attribute_names.map(&:to_sym) - [:id, :created_at, :updated_at]
  end
end
