class CreateUserLinkRelationships < ActiveRecord::Migration
  def change
    create_table :user_link_relationships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
