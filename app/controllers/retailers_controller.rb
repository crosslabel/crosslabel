class RetailersController < ApplicationController
  def index
    @shops = Retailer.all
  end

  def show
    @shop = Retailer.find(params[:id])
    @products = @shop.products.order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @shops = Retailer.all
    render layout: 'transparent_header'

  end
end
