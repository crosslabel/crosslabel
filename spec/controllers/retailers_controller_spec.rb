require 'rails_helper'

RSpec.describe RetailersController, type: :controller do
  let(:retailer) { FactoryGirl.create(:retailer)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, name: retailer.name
      expect(response).to render_template(:show)
    end
  end

end
