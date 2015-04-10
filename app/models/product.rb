class Product < ActiveRecord::Base
  searchkick autocomplete: ['title']
  has_and_belongs_to_many :categories
  belongs_to :shop
  validates_presence_of :unit_price, :title, :image, :link
  before_save { self.unit_price = self.unit_price.gsub(/[^0-9]/,'').to_i }
  scope :mens, lambda { where(for_men: true)}
  scope :womens, lambda { where(for_men: false )}

  def self.trending
    order(upvotes_count: :asc).limit(50)
  end


end
