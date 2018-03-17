class AddOrderToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_reference :events, :order, index: true
  end
end
