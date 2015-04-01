class HomeController < ApplicationController
  def index

  end

  def explore
    @products = Product.includes(:categories, :upvotes).page(params[:page]).per(15)

  end

  def trending
  end
end
