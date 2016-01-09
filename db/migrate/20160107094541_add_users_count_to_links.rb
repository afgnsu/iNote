class AddUsersCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :users_count, :integer, null: false, default: 0
  end
end
