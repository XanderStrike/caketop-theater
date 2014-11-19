require 'rails_helper'

RSpec.describe Page, :type => :model do
  describe 'callbacks' do
    it 'should parse text with markdown and put it in contents on save' do
      page = Page.new(text: "# a \n\n b `c`")
      expect(page.content).to eq(nil)
      page.save
      expect(page.content).to eq("<h1>a</h1>\n\n<p>b <code>c</code></p>\n")
    end
  end
end
