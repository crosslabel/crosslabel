class Product < ActiveRecord::Base
  validates_presence_of :unit_price, :title, :image, :link
  before_save { self.unit_price = self.unit_price.gsub(/[^0-9]/,'').to_i }

  scope :mens, -> { where(for_men: true)}
  scope :womens, -> { where(for_men: false )}
  has_and_belongs_to_many :categories
end
