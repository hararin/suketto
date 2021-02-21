class ChangeDataDatetimeToRequests < ActiveRecord::Migration[5.2]
  def change
  	change_column :requests, :datetime, :datetime
  end
end
