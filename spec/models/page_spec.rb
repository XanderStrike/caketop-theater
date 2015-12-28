# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'callbacks' do
    it 'should parse text with markdown and put it in contents on save' do
      page = create(:page)
      expect(page.content).to_not eq(nil)
    end
  end
end
