class Upvote < ActiveRecord::Base
  belongs_to :upvotable, :polymorphic => true
  belongs_to :user
  validates_presence_of :user_id, :upvotable_id, :upvotable_type
  validates_uniqueness_of :upvotable_id, :scope => [:user_id]

  before_create :increment_counter
  before_destroy :decrement_counter

  private

  def increment_counter
    self.upvotable_type.constantize.increment_counter(:upvotes_count, self.upvotable_id)
  end

  def decrement_counter
    self.upvotable_type.constantize.decrement_counter(:upvotes_count, self.upvotable_id)
  end
end
