class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :username
  belong_to :user
end
