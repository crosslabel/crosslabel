FactoryGirl.define do
  factory :product_variation, :class => 'ProductVariation' do
    product_id 1
    origin_id "MyString"
    name "MyString"
    swatch_filepath "MyText"
    factory(:variation_with_images) do
      after(:create) do
        create(:product_image)
      end
    end
  end
end
