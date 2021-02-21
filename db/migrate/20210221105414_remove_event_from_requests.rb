class RemoveEventFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :event, :string
  end
end
