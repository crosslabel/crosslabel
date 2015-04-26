class Product < ActiveRecord::Base
  searchkick autocomplete: ['title']
  has_many :categories
  belongs_to :shop
  validates_presence_of :unit_price, :title, :image, :link
  before_save { self.unit_price = self.unit_price.gsub(/[^0-9]/,'').to_i }
  scope :mens, lambda { where(for_men: true)}
  scope :womens, lambda { where(for_men: false )}

  monetize :unit_price, with_currency: :usd

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


end
