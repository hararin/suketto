class PurchasedTickets < ActiveRecord::Migration[5.2]
  def change
  	drop_table :purchased_tickets
  end
end
