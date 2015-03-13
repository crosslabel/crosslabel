require 'rails_helper'

class Authorization
  include Authorizable
end


RSpec.describe Authorizable do
  let(:authorization) { Authorization.new }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authorization).to receive(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authorization.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authorization_with_token" do
    before do
      @user = FactoryGirl.create :user
      allow(authorization).to receive(:current_user).and_return(nil)
      allow(response).to receive(:response_code).and_return(401)
      allow(response).to receive(:body).and_return({"errors" => "Not authorized"}.to_json)
      allow(authorization).to receive(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authorized"
    end

    it {  should respond_with 401 }
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        authorization.stub(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        authorization.stub(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end

end
