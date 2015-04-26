FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Product#{n+1}"}
    description "MyText"
    homepage_product_link "www.example.com"
    original_price 110
    sale_price nil
    retailer_id 1
    category_id 1
    active true
    upvotes 0
  end

end
