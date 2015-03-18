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

  private
  def product_params
    params.require(:product).params(:title, :image, :link, :unit_price, :category_ids => [])
  end
end
