class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :link, :unit_price, :sale_price, :retailer_id
end
