class Event < ApplicationRecord
	after_create_commit { notify }
	private
	def notify
		@uID = self.user_id
		ActionCable.server.broadcast 'user_channel'+@uID.to_s, data: self.message
	end
end
