class CreatePurchasedTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_tickets do |t|

      t.timestamps
    end
  end
end
