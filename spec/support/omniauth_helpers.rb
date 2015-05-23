module Omniauth
  module AuthenticationHelpers
    def set_omniauth
        OmniAuth.config.test_mode = true
        mock_facebook
        stub_mandrill
    end

    def mock_facebook
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => "1234",
        :info => {
            :email => "foobar@example.com",
            :gender => "Male",
            :first_name => "foo",
            :last_name => "bar",
            :image => File.new("#{Rails.root}/spec/support/test_image.jpg")
          },
        :credentials => {
          :token => '123456'
        }
        })
    end

    def stub_mandrill
      stub_request(:post, "https://mandrillapp.com/api/1.0/messages/send-template.json").
         with(:body => "{\"template_name\":\"welcome-email\",\"template_content\":[],\"message\":{\"to\":[{\"email\":\"foobar@example.com\"}],\"subject\":\"Welcome to Brandly!\",\"merge_vars\":[{\"rcpt\":\"foobar@example.com\",\"vars\":[{\"name\":\"WELCOME_EMAIL_HEADING\",\"content\":\"Welcome foobar@example.com\"}]}]},\"async\":false,\"ip_pool\":null,\"send_at\":null,\"key\":\"7n9BJ502xJxqUih4ut5kpg\"}",
              :headers => {'Content-Type'=>'application/json', 'Host'=>'mandrillapp.com:443', 'User-Agent'=>'excon/0.45.3'}).
         to_return(:status => 200, :body => '{"message": "This is a test email"}', :headers => {})
    end

    def set_invalid_omniauth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end
end
