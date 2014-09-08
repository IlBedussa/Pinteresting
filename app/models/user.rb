class User < ActiveRecord::Base
  # Include default devise modules. Others available are :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :name, presence: true
  has_many :identities, :dependent => :destroy
  has_many :pins, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
      if user.nil?
        if auth.provider == 'twitter'
          user = self.generate_user_from_twitter(auth, email) 
        elsif auth.provider == 'facebook'
          user = self.generate_user_from_facebook(auth, email)  
        end
        user.save!
      end
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
  
  def self.generate_user_from_twitter(auth, email)
    puts auth
      user = User.new(name: auth.info.name,
        twitter_handle: auth.info.nickname,
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20],
        profile_picture: auth.info.image
      )
  end

  def self.generate_user_from_facebook(auth, email)
    puts "####################################"
    puts auth.info
    sep = auth.info.image.include?('?') ? '&' : '?'
      user = User.new(name: auth.info.name,
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20],
        profile_picture: auth.info.image + "#{sep}width=1000"
      )
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  
  def twitter_handle_display
    twitter_handle ? "@#{twitter_handle}" : ""
  end
  
  def profile_pic_url
    return profile_picture if profile_picture.present?
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://www.gravatar.com/#{hash}" 
  end  
end