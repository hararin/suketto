class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|

    	t.integer :user_id, null: false
    	t.string :event, null: false
    	t.datetime :datetime, null: false
    	t.string :address, null: false
    	t.float :latitude
    	t.float :longitude
    	t.string :title, null: false
    	t.text :content
    	t.integer :capacity

      t.timestamps
    end
  end
end
