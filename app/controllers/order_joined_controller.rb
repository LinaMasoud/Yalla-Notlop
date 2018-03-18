class OrderJoinedController < ApplicationController
	def add
		@joind = OrderJoin.new(:order_id => params[:oid],:user_id=>current_user.id)
		@events = Event.where(user_id: current_user.id,order_id: params[:oid]).first
		@events.status = 1
		@events.save
	end
	def cancel
		@events = Event.where(user_id: current_user.id,order_id: params[:oid]).first
		@events.status = 2
		@events.save
	end
end
