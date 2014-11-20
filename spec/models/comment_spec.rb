require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe '#body_html' do
    it 'should return the body of the comment in markdown-parsed html' do
      comment = build(:comment)
      expect(comment.body_html).to eq("<p>I love this movie!</p>\n")
    end
  end
end
