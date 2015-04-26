class Product < ActiveRecord::Base
  searchkick autocomplete: ['title']
  has_many :categories
  has_many :product_variations
  belongs_to :category
  belongs_to :retailer
  validates_presence_of :original_price, :title, :homepage_product_link
  scope :mens, lambda { where(for_men: true)}
  scope :womens, lambda { where(for_men: false )}


  def self.trending
    all
  end

  def hotness
    num_of_likes = self.liked_by_count
    time_diff = (Time.now - self.created_at)
    if time_diff > 1
      score = num_of_likes * time_diff
    end
    score
  end

  def product_variation_images

  end

  def similar_items
    Product.where(category_id: self.category_id).limit(5).order('created_at ASC')
  end


end
