class HomeController < ApplicationController
  def index

  end

  def explore
    @products = Product.includes(:categories, :upvotes).order(created_at: :desc).page(params[:page]).per(15)
  end

  def trending
    @products = Product.trending
  end
end
