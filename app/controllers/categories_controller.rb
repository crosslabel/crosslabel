class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find_by(title: params[:title])
    @products = @category.products.order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
    @shops = Shop.all
    render layout: 'transparent_header'
  end
end
