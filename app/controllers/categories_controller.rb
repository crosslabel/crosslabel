class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find_by(name: params[:name])
    @products = @category.products.order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @retailers = Retailer.all
  end
end
