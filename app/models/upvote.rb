class Upvote < ActiveRecord::Base
  belongs_to :upvotable_id
  belongs_to :user_id
end
