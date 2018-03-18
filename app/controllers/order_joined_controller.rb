class OrderJoinedController < ApplicationController
	def add
		@joind = OrderJoin.new(:order_id => params[:oid],:user_id=>current_user.id)
	end
end
