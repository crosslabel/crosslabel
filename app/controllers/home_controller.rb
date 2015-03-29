class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories, :upvotes).page(params[:page]).per(9)
  end

  def explore
    @products = Product.includes(:categories, :upvotes).page(params[:page]).per(16)
  end

  def trending
  end
end
