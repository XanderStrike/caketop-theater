require 'rails_helper'


RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      pending
      get :index
      expect(response).to render_template("index")
    end

    it "calls the index method" do
      pending
      expect(controller).to receive(:index)
      get :index
    end
  end
end
