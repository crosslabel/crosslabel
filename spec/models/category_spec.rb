require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = FactoryGirl.build(:category)
  end

  subject { @category }


  describe "before save" do
    it "should downcase the title" do
      @category.save
      expect(@category.name).to eq("mytitle")
    end
  end
end
