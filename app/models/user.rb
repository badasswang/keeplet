class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :firstname, presence: true, length: {maximum: 50}
  validates :lastname, presence: true, length: {maximum: 50}

  has_many :spaces
  has_many :bookings
  has_many :reviews

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
			user.email = auth.info.email
			user.image = auth.info.image
			user.password = Devise.friendly_token[0,20]
  	end
  end

end
