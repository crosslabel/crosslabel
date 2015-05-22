class Authentication < ActiveRecord::Base
  belongs_to :user

  def self.find_with_omniauth(auth)
      Authentication.find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth, user = nil)
      user ||= User.create_with_omniauth(auth)
      Authentication.create(user_id: user.id, uid: auth['uid'], provider: auth['provider'])
  end
  
  # def self.find_with_omniauth(auth)
  #   where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token).first_or_initialize
  # end
  #
  # def self.create_with_omniauth(auth, user = nil)
  #   user ||= User.from_omniauth
  #   create(user_id: user.id, uid: auth['uid'], provider: auth['provider'])
  # end
end
