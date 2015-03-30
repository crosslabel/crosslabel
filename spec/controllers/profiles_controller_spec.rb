require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { FactoryGirl.create(:user)}
  describe "GET #show" do
    it "returns http success" do
      get :show, username: user.username
      expect(response).to render_template(:show)
    end
  end

end
