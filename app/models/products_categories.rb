class CategoriesProducts < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
  validates :title, :presence => true, :uniqueness => true, :length => { maximum: 30 } 
end
