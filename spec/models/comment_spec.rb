require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe '#body_html' do
    it 'should return the body of the comment in markdown-parsed html' do
      comment = Comment.new(body: "#a \n\n b")
      expect(comment.body_html).to eq("<h1>a</h1>\n\n<p>b</p>\n")
    end
  end
end
