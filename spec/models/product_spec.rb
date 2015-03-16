require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should respond_to(:title)}
  it { should respond_to(:unit_price)}
  it { should respond_to(:image)}
  it { should respond_to(:link)}
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:unit_price) }

end
