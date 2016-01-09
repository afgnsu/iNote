class AddCategoriesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :categories_count, :integer, null: false, default: 0
  end
end
