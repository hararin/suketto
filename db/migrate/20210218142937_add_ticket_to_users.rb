class AddTicketToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ticket, :integer, null: false, default: 0
  end
end
