FactoryGirl.define do
  factory :variation_stock do
    product_variation_id 1
    min 1
    max 1
    has_more false
  end

end
