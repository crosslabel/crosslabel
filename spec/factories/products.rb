FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Product#{n+1}"}
    description "MyText"
    image "MyString"
    link "MyString"
    unit_price "36,000"
    sale_price "75,000"
  end

end
