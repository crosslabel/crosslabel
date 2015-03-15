class User < ActiveRecord::Base
  validates :auth_token, uniqueness: true

  has_many :authentications, :dependent => :destroy
  has_one :profile, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  before_create :generate_authentication_token!

  def self.find_with_omniauth(auth)
    where(email: auth.info.email)
  end

  def self.from_omniauth(auth)
    find_with_omniauth(auth).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.username =
      Profile.create(:user_id => user.id)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end



end
