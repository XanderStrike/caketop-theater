require 'rails_helper'

RSpec.describe 'Genre Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe "genre" do
    it 'has all the attributes from the model' do
      expect(attributes_for(:genre)).to include(*(factory_attributes(Genre) - [:movie_id]))
    end

    it 'produces a valid model' do
      expect(build(:genre)).to be_valid
    end
  end
end
