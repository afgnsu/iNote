class RemoveUserIdFromCategories < ActiveRecord::Migration
  
  def self.up
    remove_column :categories, :user_id
  end
  
end
