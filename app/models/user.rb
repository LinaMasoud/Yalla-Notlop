class User < ApplicationRecord
	has_many :order
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   
end
