class ItemsController < ApplicationController
  before_action :authenticate_user!
	before_action :item_params , only: [:create]

	def create
    @order = Order.find(params[:order_id])
    @item = @order.items.create(item_params)

    redirect_to order_path(@order)
  	end

  	def destroy
    @order = Order.find(params[:order_id])
    @item = @order.items.find(params[:id])
    @item.destroy
    redirect_to order_path(@order)
    end

  	private
    def item_params
      params.require(:item).permit(:user_id, :item, :amount , :price , :comment)
    end
end
