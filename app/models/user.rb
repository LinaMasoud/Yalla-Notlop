class User < ApplicationRecord
	has_and_belongs_to_many :orders

  before_create { generate_token(:auth_token) }

	#has_and_belongs_to_many :groups
	has_many :order
    has_many :groups, dependent: :destroy
    has_many :group_users, dependent: :destroy
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

	def self.search(search)
		where(" users.email LIKE ?", "%#{search}%")
	end
	def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      #user.image.url = auth.info.image
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end      
  	end
   def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end



   
end
