require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe ".configured" do
    it "redirects if no settings are set" do
      expect(controller).to receive(:redirect_to)
      controller.configured
    end

    it "does not redirect if the name setting is already set" do
      create(:setting, name: "name")
      expect(controller).to_not receive(:redirect_to)
      controller.configured
    end

    it "does not redirect if they have already been redirected" do
      controller.params[:first_time] = 'true'
      expect(controller).to_not receive(:redirect_to)
      controller.configured
    end
  end
end
