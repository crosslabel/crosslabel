module Omniauth
  module AuthenticationHelpers
    def set_omniauth(id)
        OmniAuth.config.test_mode = true
        stub_request(:get, "https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
          :provider => 'facebook',
          :uid => "1234",
          :info => {
              :email => "foobar@example.com",
              :gender => "Male",
              :first_name => "foo",
              :last_name => "bar",
              :image => "https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"
            },
          :credentials => {
            :token => '123456'
          }
          })

    end

    def set_invalid_omniauth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end
end
