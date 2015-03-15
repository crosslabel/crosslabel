class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    unless @product.save
      render errors: "Product was not created", status: 402
    end
  end
end
