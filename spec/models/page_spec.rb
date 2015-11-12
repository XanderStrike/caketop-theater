require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'callbacks' do
    it 'should parse text with markdown and put it in contents on save' do
      page = create(:page)
      expect(page.content).to match(/This\ is\ a\ test\ page!/)
    end
  end
end
