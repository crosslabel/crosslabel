class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  validates :username, :presence => true, :uniqueness => :true
  belongs_to :user
end
