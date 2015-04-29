class ProductViewsCounter
  @queue = :product_views_counter

  def self.perform(product_id)
    product = Product.find(product_id)
    product.increment!(:viewed_count, by = 1)
  end
end
