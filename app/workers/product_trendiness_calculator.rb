class ProductTrendinessCalculator
  @queue = :product_trendiness_calculator

  def self.perform(product_id)
    product = Product.find(product_id)
    product.set_trendiness_score
  end
end
