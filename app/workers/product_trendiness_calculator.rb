class ProductTrendinessCalculator
  @queue = :product_trendiness_calculator

  def self.perform
    Product.all.each {|product| product.set_trendiness_score }
  end
end
