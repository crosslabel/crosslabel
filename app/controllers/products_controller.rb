class ProductsController < ApplicationController
  before_action :logged_in_user, :only => [:create, :vote]
  def index
    @products = Product.search(params[:search]).order("created_at DESC")
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @produce.save
  end

  private
  def product_params
    params.require(:product).params(:title, :image, :link, :unit_price, :category_ids => [])
  end
end
