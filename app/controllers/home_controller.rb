class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories).all
  end
end
