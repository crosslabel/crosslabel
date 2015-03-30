require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  describe "Logging in" do
    before do
      let(:user) { FactoryGirl.create(:user)}
      sign_in user
    end
  end
end
