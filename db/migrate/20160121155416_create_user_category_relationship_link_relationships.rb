class CreateUserCategoryRelationshipLinkRelationships < ActiveRecord::Migration
  def change
    create_table :user_category_relationship_link_relationships do |t|
      t.integer :user_category_relationship_id
      t.integer :link_id

      t.timestamps null: false
    end
  end
end
