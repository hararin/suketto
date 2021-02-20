class AddTicketIdToPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :ticket_id, :integer
  	add_column :purchases, :quantity, :integer
  end
end
