class HomeController < ApplicationController
  def index
    @products = Product.all.order(created_at: :desc).limit(16)
    render :layout => "transparent_header"
  end

  def explore
    @products = Product.all.order("RANDOM()").page(params[:page]).per(20)
    @categories = Category.all
    @retailers = Retailer.all.limit(10)
  end

  def trending
    @products = Product.trending
  end

  def recommended
    @products = Product.trending.page(params[:page]).per(16)
  end
end
