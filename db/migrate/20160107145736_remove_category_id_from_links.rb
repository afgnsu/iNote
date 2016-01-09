class RemoveCategoryIdFromLinks < ActiveRecord::Migration
  def self.up
    remove_column :links, :category_id
  end
end
