class AddCategoriesCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :categories_count, :integer, null: false, default: 0
  end
end
