class Order < ApplicationRecord
  has_many :items, :dependent => :delete_all 
  has_and_belongs_to_many :users
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
