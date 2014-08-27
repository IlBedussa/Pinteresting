class User < ActiveRecord::Base
  # Include default devise modules. Others available are :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :name, presence: true
  has_many :identities, :dependent => :destroy
  has_many :pins, :dependent => :destroy
  
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
      user = User.new(name: auth.info.name,
        twitter_handle: auth.info.nickname,
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20]
      )
  end

  def self.generate_user_from_facebook(auth, email)
      user = User.new(name: auth.info.name,
        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20]
      )
  end
  
  def twitter_handle_display
    twitter_handle ? "@#{twitter_handle}" : ""
  end  
end