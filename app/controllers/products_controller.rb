class ProductsController < ApplicationController
  before_action :logged_in_user, :only => [:create]
  def index
    if params[:query].present?
      @products = Product.search(params[:query], page: params[:page])
    else
      @products = Product.all.page params[:page]
    end
  end

  def autocomplete
    render json: Product.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end

  def show
    @product = Product.find(params[:id])
    Resque.enqueue(ProductViewsCounter, @product.id)
    if current_user
      @product.viewed(current_user)
    end


    Analytics.track(user_id: "#{current_user.try(:id)}", anonymous_id: "anonymous_user", event: 'Viewed Product', properties: { user: { id: "#{current_user.try(:id)}", name: "#{current_user.try(:name)}", email: "#{current_user.try(:email)}" }, product: { id: "#{@product.id}", title: "#{@product.title}", original_price: "#{@product.original_price}", category: "#{@product.category.name}", retailer: "#{@product.retailer.name}" }, keen: {
        addons: [
            {
                name: "keen:ip_to_geo",
                input: {
                    ip: "ip_address"
                },
                output: "ip_geo_info"
            },
            {
                name: "keen:ua_parser",
                input: {
                    ua_string: "user_agent"
                },
                output: "parsed_user_agent"
            }
        ]
    },
    ip_address: "${keen.ip}",
    user_agent: "${keen.user_agent}"})
  end

  def create
    @product = Product.new(product_params)
    @produce.save
  end

  private
  def product_params
    params.require(:product).params(:title, :homepage_product_link, :original_price, :category_ids => [])
  end
end
