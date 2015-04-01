class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  belongs_to :user
  validates_uniqueness_of :user_id
end
