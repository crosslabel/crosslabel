require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user)}

  describe "welcome email" do
    before(:each) do
      template_name = "test-email"
      template_content = []
      message = {
        to: [{email: user.email}],
        subject: "Welcome to Brandly!",
        merge_vars: [
          {rcpt: user.email,
          vars: [
            {name: "WELCOME_EMAIL_HEADING", content: "Welcome #{user.email}"}
            ]}
        ]
      }
      api_key = "thisisafakeapikey"
      mandrill_client = Mandrill::API.new(api_key)
      @json_response = mandrill_client.messages.send_template template_name, template_content, message
    end

    it "sends an email" do
      expect(@json_response).to_not be_nil
    end

    it "renders the receiver email" do
      expect(@json_response["status"]).to eq("sent")
    end
  end
end
