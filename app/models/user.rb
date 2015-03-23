class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :upvotes, :dependent => :destroy
  has_one :profile, :dependent => :destroy

  before_create :generate_authentication_token!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :auth_token, uniqueness: true
  validates :email, :presence => true, :length => { maximum: 256}, :format => { with: VALID_EMAIL_REGEX }, :uniqueness => { case_sensitive: false}
  validates :username, :uniqueness => :true


  def self.find_with_omniauth(auth)
    where(email: auth.info.email)
  end

  def self.from_omniauth(auth)
    find_with_omniauth(auth).first_or_create do |user|
      user.email = auth.info.email
      user.username = "user" + Devise.friendly_token[0,10]
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def create_profile(auth)
    Profile.create!(:user_id => self.id, :profile_image => auth.try(:info).image || nil)
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end
