class Api::V1::ProductsController < ApplicationController
    before_action :authenticate_with_token!, only: [:create]

    respond_to :json

    def index
      respond_with Product.all
    end

    def show
      respond_with @product = Product.find(params[:id])
    end

    def create
      product = Product.new(product_params)
      if product.save
        render json: product, status: 201, location: [:api, product]
      else
        render json: { errors: product.errors}, status: 422
      end
    end

    def update
      product = Product.find(params[:id])
      if product.update(product_params)
        render json: product, status: 200, location: [:api, product]
      else
        render json: { errors: product.errors }, status: 422
      end
    end

    def destroy
      product = Product.find(params[:id])
      product.destroy
      head 204
    end
    private
    def product_params
      params.require(:product).permit(:title, :description, :image, :link, :unit_price, :sale_price)
    end
end
