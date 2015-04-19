require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user)}

  describe "welcome email" do
    before(:each) do
      Excon.defaults[:mock] = true
      stub_request(:post, "https://mandrillapp.com/api/1.0/messages/send-template.json").
         with(:body => "{\"template_name\":\"test-email\",\"template_content\":[],\"message\":{\"to\":[{\"email\":\"example@example.com\"}],\"subject\":\"Welcome to Brandly!\",\"merge_vars\":[{\"rcpt\":\"example@example.com\",\"vars\":[{\"name\":\"WELCOME_EMAIL_HEADING\",\"content\":\"Welcome example@example.com\"}]}]},\"async\":false,\"ip_pool\":null,\"send_at\":null,\"key\":\"123456789\"}",
              :headers => {'Content-Type'=>'application/json', 'Host'=>'mandrillapp.com:443', 'User-Agent'=>'excon/0.45.2'}).
         to_return(:status => 200, :body => "", :headers => {})
    end

    after(:each) do
      WebMock.reset!
    end
  end
end
