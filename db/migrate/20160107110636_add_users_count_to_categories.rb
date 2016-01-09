class AddUsersCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :users_count, :integer, null: false, default: 0
  end
end
