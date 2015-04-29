require 'rails_helper'

RSpec.describe Product, type: :model do

  before { @product = FactoryGirl.build(:product)}

  subject { @product }
  it { should respond_to(:title)}
  it { should respond_to(:original_price)}
  it { should respond_to(:sale_price)}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:original_price) }

  it { should be_valid }

  describe "before save" do
    it "transform the unit price string into integer" do
      @product.save
      expect(@product.original_price).to be_kind_of(Float)
    end
  end
  #
  # describe "product variation images" do
  #   it "returns all the images of the product" do
  #     product = FactoryGirl.create(:product_with_variation)
  #     expect(product.product_variation_images).to eq([])
  #   end
  # end
  describe "view products" do
    before do
      @user = FactoryGirl.create(:user)
      @product1 = FactoryGirl.create(:product)
      @product2 = FactoryGirl.create(:product)
    end

    it "should add product to user's set" do
      @product1.viewed(@user)
      @product2.viewed(@user)
      expect(@user.recently_viewed_product_ids).to eql([@product1.id.to_s, @product2.id.to_s])
    end

    it "stores unique members" do
      @product1.viewed(@user)
      @product2.viewed(@user)
      @product2.viewed(@user)
      expect(@user.recently_viewed_product_ids).to eql([@product1.id.to_s, @product2.id.to_s])
    end
  end


  describe "get similar items" do
    context "items in category" do
      it "returns array of items items in same category" do
        product1 = FactoryGirl.create(:product, :category_id => 1)
        product2 = FactoryGirl.create(:product, :category_id => 1)
        product3 = FactoryGirl.create(:product, :category_id => 2)


        expect(@product.similar_items).to eq([product1, product2])

      end
    end

    context "no other items in category" do
      it "returns an empty array" do
        product2 = FactoryGirl.create(:product, :category_id => 2)
        product2 = FactoryGirl.create(:product, :category_id => 4)

        expect(@product.similar_items).to eq([])
      end
    end
  end
end
