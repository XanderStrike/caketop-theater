require 'rails_helper'

RSpec.describe 'Page Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'page' do
    it 'creates an page with a name' do
      page = build(:page)
      expect(page.name).to_not eq(nil)
    end

    it 'has all the attributes from the model' do
      expect(attributes_for(:page)).to include(*(factory_attributes(Page) - [:content]))
    end

    it 'produces a valid model' do
      expect(build(:page)).to be_valid
    end
  end
end
