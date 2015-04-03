class Shop < ActiveRecord::Base
  validates :description, :presence => true, :length => { maximum: 1200}
  validates :name, :presence => true, :length => {maximum: 100}
  validates :website, :presence => true, :length => {maximum: 100}

  has_many :products
end
