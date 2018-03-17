class Event < ApplicationRecord
	after_create_commit { notify }
	private
	def notify
		@uID = self.user_id
		ActionCable.server.broadcast 'user_channel'+@uID.to_s, data: {msg:self.message,order:self.order_id}
	end
end
