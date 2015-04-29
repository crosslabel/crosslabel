class ProductsController < ApplicationController
  before_action :logged_in_user, :only => [:create]
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
    @product.viewed(current_user)
    # Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: 'Viewed Product', properties: { id: "#{@product.id}", name: "#{@product.title}", price: "#{@product.unit_price}", category: "#{@product.categories.first.title}", retailer: "#{@product.shop.name}"})
  end

  def create
    @product = Product.new(product_params)
    @produce.save
  end

  private
  def product_params
    params.require(:product).params(:title, :homepage_product_link, :original_price, :category_ids => [])
  end
end
