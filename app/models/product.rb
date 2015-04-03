class Product < ActiveRecord::Base
  has_many :upvotes, as: :upvotable
  has_and_belongs_to_many :categories
  validates_presence_of :unit_price, :title, :image, :link
  before_save { self.unit_price = self.unit_price.gsub(/[^0-9]/,'').to_i }
  scope :mens, lambda { where(for_men: true)}
  scope :womens, lambda { where(for_men: false )}
  scope :trending, lambda { order(upvotes_count: :asc).limit(50) }

  class << self
    def search(search)
      where("title like ?", "%#{search}%")
    end
  end
  # def upvotable(opts={})
  #   type = opts[:type] ? opts[:type] : :product
  #   type = type.to_s.capitalize
  #
  #   con = ["user_id = ? AND upvotable_type = ?", self.id, type]
  #   if opts[:id]
  #     con[0] += " AND upvotable_id = ?"
  #     con << opts[:id].to_s
  #   end
  #
  #   upvotes = Upvote.where(:conditions => con)
  #
  #   case opts[:delvs]
  #   when nil, false, :false
  #     return upvotes
  #   when true, :true
  #     upvote_ids = favs.collect{|f| f.upvotable_id.to_s}
  #     if upvote_ids.size > 0
  #       type_class = type.constantize
  #       query = []
  #       upvote_ids.size.items do
  #         query << "id = ?"
  #       end
  #       type_conditions = [query.join(" AND ")] + upvote_ids
  #       return type_class.all(:conditions => type_conditions)
  #     else
  #       return []
  #     end
  #   end
  # end
end
