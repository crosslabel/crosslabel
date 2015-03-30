class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories, :upvotes).page(params[:page]).per(12)
  end

  def explore
  end

  def trending
  end
end
