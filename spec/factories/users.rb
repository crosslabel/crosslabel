FactoryGirl.define do
  factory :user do
    email "example@example.com"
    username "Exampleuser"
    password "12345678"
    password_confirmation "12345678"
  end

end
