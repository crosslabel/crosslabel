FactoryGirl.define do
  factory :user do
    email "example@example.com"
    username "Example user"
    password "12345678"
    password_confirmation "12345678"
  end

end
