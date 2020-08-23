class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook twitter]

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :delete_all

  validates :name, presence: true

  ### OMNIAUTH METHODS ###
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    email = auth.info.email ? auth.info.email : "change@me-#{auth.uid}-#{auth.provider}.com"
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
  ### OMNIAUTH METHODS ###
end
