class Product < ActiveRecord::Base
  validates_presence_of :unit_price, :title, :image, :link
end
