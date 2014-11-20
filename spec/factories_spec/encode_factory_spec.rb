require 'rails_helper'

RSpec.describe 'Encode Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe "encode" do
    it 'has all the attributes from the model' do
      expect(attributes_for(:encode)).to include(*(factory_attributes(Encode) - [:movie_id]))
    end

    it 'produces a valid model' do
      expect(build(:encode)).to be_valid
    end
  end
end
