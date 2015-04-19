FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com"}
    sequence(:username) { |n| "exampleuser#{n}"}
    password "12345678"
    password_confirmation "12345678"
  end

end
