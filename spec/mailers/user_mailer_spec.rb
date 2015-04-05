require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user)}

  describe "welcome email" do
    before(:each) do
      UserMailer.welcome_email(user).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
    it "sends an email" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "renders the receiver email" do
      expect(ActionMailer::Base.deliveries.first.to[0]).to eq(user.email)
    end
  end
end
