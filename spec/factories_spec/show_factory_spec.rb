require 'rails_helper'

RSpec.describe 'Show Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'show' do
    it 'has all the attributes from the model' do
      expect(attributes_for(:show)).to include(*(factory_attributes(Show)))
    end

    it 'produces a valid model' do
      expect(build(:show)).to be_valid
    end
  end
end
