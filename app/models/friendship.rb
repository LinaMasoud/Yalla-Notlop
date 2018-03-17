class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => "User"
	
	def name_with_initial
    "#{User.find(friend_id).name}"
  end
end
