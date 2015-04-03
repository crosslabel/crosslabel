require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) { FactoryGirl.create(:shop)}
  subject { shop }
  it { should respond_to(:name)}
  it { should respond_to(:website)}
  it { should respond_to(:description)}
  it { should respond_to(:twitter_url)}
  it { should respond_to(:facebook_url)}
  it { should validate_length_of(:description).is_at_most(1200) }
  it { should validate_length_of(:name).is_at_most(100) }
  it { should validate_length_of(:website).is_at_most(100) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:website) }
  it { should validate_presence_of(:description) }

  it { should have_many(:products)}
  it { should be_valid}


end
