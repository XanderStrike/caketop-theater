require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  before(:each) do
    create_settings
  end

  describe "GET show" do
		it "runs the show method and renders the show partial" do
			expect(controller).to receive(:show)
			get :show, id: 1
			expect(response).to render_template(:show)
		end

		it "runs the appropriate queries" do
			expect(Genre).to receive(:find)
			expect(Movie).to receive(:where)
			expect(Genre).to receive_message_chain('where.map')
			get :show, id: 1
		end
  end
end
