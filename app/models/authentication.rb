class Authentication < ActiveRecord::Base
  belongs_to :user

  def self.find_with_omniauth(auth)
    Authentication.find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth, user = nil)
    user ||= User.create_with_omniauth(auth)
    Authentication.create(user_id: user.id, uid: auth['uid'], provider: auth['provider'])
  end
end
