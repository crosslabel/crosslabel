class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  validates :title, :presence => true, :uniqueness => true
  before_save { self.title = self.title.downcase }

  def self.tops
    category = Category.where(title: 'tops')
  end
end
