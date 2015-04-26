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
    it "should transform the unit price string into integer" do
      @product.save
      expect(@product.unit_price).to eq(36000)
    end
  end
end
