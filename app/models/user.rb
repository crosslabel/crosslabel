class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  before_create :generate_authentication_token!

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => ":style/default_avatar.jpg"
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 3.megabytes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :auth_token, uniqueness: true
  validates :email, :presence => true, :length => { maximum: 256}, :format => { with: VALID_EMAIL_REGEX }, :uniqueness => { case_sensitive: false}
  # validates :username, :presence => true, :uniqueness => :true, :length => { maximum: 15}

  SOCIALS = {
    facebook: 'facebook',
    google_oauth2: 'google',
    linkedin: 'linkedin'
  }

  recommends :products

  def self.from_omniauth(auth, current_user)
    authentication = Authentication.where(:provider => auth.provider, :uid => auth.uid.to_s,
                                      :token => auth.credentials.token)
                                      .first_or_initialize
    if authentication.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0, 20]
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.avatar = open(auth.info.image)
        user.save!
        user.send_welcome_email
      end
      authentication.user = user
      authentication.save
    end
    authentication.user
  end

  def self.find_with_omniauth(auth)
    where(email: auth.info.email)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def recently_viewed_product_ids
    $redis.smembers "users::viewedrecently::#{self.id}"
  end

  def recently_viewed_products
    Product.where(:id => recently_viewed_product_ids)
  end

  def remove_avatar
    update_attribute(:avatar, nil)
  end

  def set_default_facebook_photo
    auth = self.authentications.find_by(provider: "facebook")
    update_attribute(:avatar, "https://graph.facebook.com/" + auth.uid + "/picture?type=large")
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def activated?
    self.activated
  end
end
