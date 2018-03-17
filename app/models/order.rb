class Order < ApplicationRecord
  has_many :items, :dependent => :delete_all 
  has_and_belongs_to_many :users
  belongs_to :user
  has_many :orders_users, :dependent => :delete_all 
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  

 
  	


  after_create_commit { create_event }
  def create_event()
  	@orderid = Order.last.id
  	@userIDs = User.joins(:orders).where(orders: {id: @orderid})
  	@userIDs.each  do |user|
    	@event = Event.create message: "A new order has been created", user_id: user.id
	end
  end
  
end
