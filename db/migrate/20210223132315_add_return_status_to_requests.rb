class AddReturnStatusToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :return_status, :integer, default: 0, null: false
  end
end
