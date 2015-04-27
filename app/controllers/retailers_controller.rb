class RetailersController < ApplicationController
  def index
    @retailers = Retailer.all
    render layout: 'transparent_header'
  end

  def show
    @retailer = Retailer.find(params[:id])
    @products = @retailer.products.order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @retailers = Retailer.all
  end
end
