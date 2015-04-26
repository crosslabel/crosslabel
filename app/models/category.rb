class Category < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  before_save { self.title = self.title.downcase }

  def self.tops
    category = Category.where(title: 'tops')
  end
end
