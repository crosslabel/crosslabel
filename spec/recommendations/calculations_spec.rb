require 'rails_helper'
describe Recommendations::Helpers::Calculations do
  before(:each) do
    @user  = FactoryGirl.create(:user)
    5.times { |x| instance_variable_set(:"@user#{x+1}", FactoryGirl.create(:user))}
    5.times { |x| instance_variable_set(:"@product#{x+1}", FactoryGirl.create(:product))}

    [@product1, @product2].each { |obj| @user.like(obj) }

    # @user.similarity_between(@user1).should == 1.0
    [@product1, @product2].each { |obj| @user1.like(obj) }

    # @user.similarity_with(@user2) should == 0.5
    [@product1, @product2, @product3, @product4].each { |obj| @user2.like(obj)}

    # @user.similarity_with(@user3) should == 0.0
    [@product3, @product4].each { |obj| @user3.like(obj) }
    # @user.similarity_with(@user4) should == 0.33
    [@product1, @product4, @product5].each { |obj| @user4.like(obj)}
  end

  describe "similarity_between" do
    it "returns 1.0" do
      score = Recommendations::Helpers::Calculations.similarity_between(@user.id, @user1.id)
      expect(score).to eql(1.0)
    end
  end
end
