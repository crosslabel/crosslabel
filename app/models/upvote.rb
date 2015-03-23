class Upvote < ActiveRecord::Base
  belongs_to :upvotable, :polymorphic => true
  belongs_to :user
  validates_presence_of :user_id, :upvotable_id, :upvotable_type
  validates_uniqueness_of :upvotable_id, :scope => [:user_id]
end
