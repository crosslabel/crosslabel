require 'rails_helper'

describe Recommendations::Helpers::RedisKeyMapper do
  describe "similarity_set_for" do
    it "returns correct key" do
      key = Recommendations::Helpers::RedisKeyMapper.similarity_set_for(1)
      expect(key).to eql("recommendations:users:1:similarities")
    end
  end

  describe "liked_by_set_for" do
    it "returns correct key" do
      key = Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(Product, 1)
      expect(key).to eql("recommendations:products:1:liked_by")
    end
  end

  describe "score_set_for" do
    it "returns correct key" do
      key = Recommendations::Helpers::RedisKeyMapper.score_set_for(Product)
      expect(key).to eql("recommendations:products:scores")
    end
  end

  describe "temp_set_for" do
    it "returns correct key" do
      key = Recommendations::Helpers::RedisKeyMapper.temp_set_for(Product, 1)
      expect(key).to eql("recommendations:products:1:temp")
    end
  end
end
