class DropOrdersUsers < ActiveRecord::Migration[5.1]
  def change
  	drop_table :orders_users

  end
end
