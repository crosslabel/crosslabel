def set_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uuid => "1234",
      :info => {
          :email => "foobar@example.com",
          :gender => "Male",
          :first_name => "foo",
          :last_name => "bar",
          :image => "teststring.jpg"
        }
      })
end

def set_invalid_omniauth

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

end
