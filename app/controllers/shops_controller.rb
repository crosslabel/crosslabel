class ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    @products = @shop.products.order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @shops = Shop.all
    render layout: 'transparent_header'

  end
end
