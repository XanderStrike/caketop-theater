# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Setting Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'setting' do
    it 'has all the attributes from the model' do
      expect(attributes_for(:setting)).to include(*(factory_attributes(Setting)))
    end

    it 'produces a valid model' do
      expect(build(:setting)).to be_valid
    end
  end
end
