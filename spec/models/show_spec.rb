require 'rails_helper'

RSpec.describe Show, type: :model do
  describe '#poster' do
    it 'should return the path to the poster' do
      show = Show.new(id: 1234)
      expect(show.poster).to eq('/posters/tv_1234.jpg')
    end
  end

  describe '#backdrop' do
    it 'should return the path to the backdrop' do
      show = Show.new(id: 1234)
      expect(show.backdrop).to eq('/backdrops/tv_1234.jpg')
    end
  end
end
