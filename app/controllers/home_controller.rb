class HomeController < ApplicationController
  before_action :activated_only
  def index
    @products = Product.all.order(created_at: :desc).limit(16)
    render :layout => "transparent_header"
  end

  def explore
    @trending_products = Product.trending
    @recommended_products = Product.includes(:retailer, :category).all.page(params[:page]).per(20)
    @categories = Category.all
    @retailers = Retailer.all.limit(10)
    render :layout => 'transparent_header'
  end

end
