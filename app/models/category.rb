class Category < ActiveRecord::Base
  has_many :products

  validates :name, :presence => true, :uniqueness => true
  before_save { self.name = self.name.downcase }
end
