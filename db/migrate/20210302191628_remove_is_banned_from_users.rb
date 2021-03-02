class RemoveIsBannedFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_banned ,:boolean
  end
end
