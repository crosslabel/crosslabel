class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories, :upvotes).all
  end
end
