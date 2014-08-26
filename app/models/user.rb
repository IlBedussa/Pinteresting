class User < ActiveRecord::Base
  # Include default devise modules. Others available are :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :name, presence: true

  has_many :pins
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email || auth.provider == "google_oauth2")
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.try(:name),
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

end