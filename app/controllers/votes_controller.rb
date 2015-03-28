class VotesController < ApplicationController
  before_action :load_product, only: [:create, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @vote = @product.upvotes.build(user_id: current_user.id)
      if @vote.save
        respond_to do |format|
        format.js
        format.html { redirect_to root_path }
        end
     end
  end

  def destroy
    @vote = @product.upvotes.find_by(user_id: current_user.id)
    respond_to do |format|
      if @vote.destroy
        format.js
        format.html { redirect_to root_path }
      end
    end
  end

    private
    def load_product
      @product = Product.find(params[:product_id])
    end
end
