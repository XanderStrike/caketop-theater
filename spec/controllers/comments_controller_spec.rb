require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    create_settings
  end

  describe "POST create" do
    let (:comment_attributes) { attributes_for(:comment) }

    it "creates a new comment" do
      count = Comment.count
      post :create, comment: comment_attributes
      expect(Comment.count).to eq(count + 1)
    end

    it "redirects to the home page if it doesn't have a movie" do
      post :create, comment: comment_attributes
      expect(response).to redirect_to("/")
    end

    it "redirects to the movie if there is one" do
      id = create(:movie).id
      comment_attributes[:movie_id] = id
      post :create, comment: comment_attributes
      expect(response).to redirect_to("/movies/#{id}")
    end
  end
end
