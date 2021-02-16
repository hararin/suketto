class AddImageIdToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :image_id, :string
  end
end
