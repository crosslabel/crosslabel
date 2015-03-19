class Product < ActiveRecord::Base
  validates_presence_of :unit_price, :title, :image, :link
  before_save :convert_unit_price_to_int


  scope :mens, -> { where(for_men: true)}
  scope :womens, -> { where(for_men: false )}
  has_and_belongs_to_many :categories

  private

  def convert_unit_price_to_int
    self.unit_price = self.unit_price.gsub(/[^0-9]/,'').to_i
  end
end
