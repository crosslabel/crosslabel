require 'rails_helper'

RSpec.describe RetailersController, type: :controller do
  let(:shop) { FactoryGirl.create(:shop)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: shop.id
      expect(response).to render_template(:show)
    end
  end

end
