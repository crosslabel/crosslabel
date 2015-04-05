require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user)}

  describe "welcome email" do
    before(:each) do
      Excon.defaults[:mock] = true
      stub_request(:post, "https://mandrillapp.com/api/1.0/messages/send-template.json").
           with(:body => "{\"template_name\":\"test-email\",\"template_content\":[],\"message\":{\"to\":[{\"email\":\"example@example.com\"}],\"subject\":\"Welcome to Brandly!\",\"merge_vars\":[{\"rcpt\":\"example@example.com\",\"vars\":[{\"name\":\"WELCOME_EMAIL_HEADING\",\"content\":\"Welcome example@example.com\"}]}]},\"async\":false,\"ip_pool\":null,\"send_at\":null,\"key\":\"thisisafakeapikey\"}",
                :headers => {'Content-Type'=>'application/json', 'Host'=>'mandrillapp.com:443', 'User-Agent'=>'excon/0.45.1'}).
           to_return(:status => 200, :body => "{\"template_name\":\"test-email\",\"template_content\":[],\"message\":{\"to\":[{\"email\":\"example@example.com\"}],\"subject\":\"Welcome to Brandly!\",\"merge_vars\":[{\"rcpt\":\"example@example.com\",\"vars\":[{\"name\":\"WELCOME_EMAIL_HEADING\",\"content\":\"Welcome example@example.com\"}]}]},\"async\":false,\"ip_pool\":null,\"send_at\":null,\"key\":\"thisisafakeapikey\"}", :headers => {})

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
      @response = mandrill_client.messages.send_template template_name, template_content, message
    end

    after(:each) do
      WebMock.reset!
    end

    it "sends an email" do
      expect(@response["message"]["to"][0]["email"]).to eq(user.email)
    end

    it "renders the correct template" do
      expect(@response["template_name"]).to eq("test-email")
    end
  end
end
