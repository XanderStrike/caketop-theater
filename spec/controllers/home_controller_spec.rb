require 'rails_helper'


RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "calls the index method" do
      expect(controller).to receive(:index)
      get :index
    end
  end
end
