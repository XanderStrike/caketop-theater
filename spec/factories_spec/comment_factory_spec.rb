require 'rails_helper'

RSpec.describe 'Comment Factory', type: :factory do
  include FactoryGirl::Syntax::Methods

  describe 'comment' do
    it 'has all the attributes from the model' do
      expect(attributes_for(:comment)).to include(*(factory_attributes(Comment) - [:movie_id, :content]))
    end

    it 'produces a valid model' do
      expect(build(:comment)).to be_valid
    end
  end
end
