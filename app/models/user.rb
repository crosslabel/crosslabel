class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :upvotes, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  before_create :generate_authentication_token!
  after_create :create_profile

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentPresenceValidator, :attributes => :avatar
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 1.megabytes


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :auth_token, uniqueness: true
  validates :email, :presence => true, :length => { maximum: 256}, :format => { with: VALID_EMAIL_REGEX }, :uniqueness => { case_sensitive: false}
  validates :username, :presence => true, :uniqueness => :true




  def self.find_with_omniauth(auth)
    where(email: auth.info.email)
  end

  def self.from_omniauth(auth)
    find_with_omniauth(auth).first_or_create do |user|
      user.email = auth.info.email
      user.username = "user" + Digest::SHA1.base64digest(auth.uid)
      user.password = Devise.friendly_token[0,20]
      user.profile_picture = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # def create_default_profile
  #   Profile.create!(:user_id => self.id)
  # end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

end
