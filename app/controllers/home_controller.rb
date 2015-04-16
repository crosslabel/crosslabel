class HomeController < ApplicationController
  def index
    render :layout => "home_index"
  end

  def explore
    @products = Product.includes(:categories).order(created_at: :desc).page(params[:page]).per(16)
  end

  def trending
    @products = Product.trending
  end
end
