class ProductsController < ApplicationController
  before_action :logged_in_user, :only => [:create, :vote]
  def index
    if params[:query].present?
      @products = Product.search(params[:query], page: params[:page])
    else
      @products = Product.all.page params[:page]
    end
  end

  def autocomplete
    render json: Product.search(params[:query], autocomplete: true, limit: 10).map(&:title)
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
