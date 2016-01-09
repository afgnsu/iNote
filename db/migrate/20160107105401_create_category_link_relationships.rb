class CreateCategoryLinkRelationships < ActiveRecord::Migration
  def change
    create_table :category_link_relationships do |t|
      t.references :category, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
