class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories).order(created_at: :desc).limit(16)
    @tiny = Product.all.limit(24)
    render :layout => "home_index"
  end

  def explore
    @products = Product.includes(:categories).order(created_at: :desc).page(params[:page]).per(20)
  end

  def trending
    @products = Product.trending
  end

  def recommended
    @products = Product.trending.page(params[:page]).per(16)
  end
end
