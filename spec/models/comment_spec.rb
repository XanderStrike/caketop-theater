require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'callbacks' do
    it 'should parse text with markdown and put it in contents on save' do
      comment = create(:comment)
      expect(comment.content).to eq("<h1>I love this movie!</h1>\n")
    end

    it 'requires a space after the # for headers' do
      comment = create(:comment, body: "#invalid header")
      expect(comment.content).to eq("<p>#invalid header</p>\n")
    end
  end
end
