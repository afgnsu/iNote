class AddPublicToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :private, :boolean, null: false, default: false
  end
end
