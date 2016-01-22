class AddReadToUserLinkRelationships < ActiveRecord::Migration
  def change
    add_column :user_link_relationships, :read, :boolean, null: false, default: false
  end
end
