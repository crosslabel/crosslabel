require 'rails_helper'

RSpec.describe Upvote, type: :model do
  let(:upvote) { FactoryGirl.build(:upvote)}
  subject { upvote }

  it { should respond_to(:upvotable_type)}
  it { should respond_to(:upvotable_id)}
  it { should respond_to(:user_id)}
  it { should validate_presence_of(:user_id)}
  it { should be_valid}

  describe "before create" do
    it "increments upvote count" do
      product = double(:upvotes_count => 0)
      upvote.save!
      expect(product.upvotes_count).to eq(1)
    end
  end
end
