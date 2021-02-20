class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|

    	t.integer :user_id, null: false
    	t.integer :payment_method, default: 0, null: false
    	t.integer :charge, null: false

      t.timestamps
    end
  end
end
