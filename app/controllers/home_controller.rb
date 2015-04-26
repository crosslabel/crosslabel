class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories).order(created_at: :desc).limit(16)
    render :layout => "transparent_header"
  end

  def explore
    @products = Product.includes(:categories).order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @retailers = Retailer.all.limit(10)
    render :layout => "transparent_header"
  end

  def trending
    @products = Product.trending
  end

  def recommended
    @products = Product.trending.page(params[:page]).per(16)
  end
end
