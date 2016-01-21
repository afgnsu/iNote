class AddPredefinedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :predefined, :boolean
  end
end
