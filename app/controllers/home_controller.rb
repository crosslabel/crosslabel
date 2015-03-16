class HomeController < ApplicationController
  def index
    @products = Product.all.limit(50)
  end
end
