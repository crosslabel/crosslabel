class HomeController < ApplicationController
  def index
    @products = Product.includes(:categories).order(created_at: :desc).limit(16)
    @tiny = Product.all.limit(24)
    unless current_user
      render :layout => "home_index"
    end
  end

  def explore
    @products = Product.includes(:categories).order(created_at: :desc).page(params[:page]).per(16)
  end

  def trending
    @products = Product.trending
  end

  def recommended
    @products = Product.trending.page(params[:page]).per(16)
  end

  def login
    render :layout => "home_index"
  end

  def signup
    render :layout => "home_index"
  end

  def reset_password
    render :layout => "home_index"
  end
end
