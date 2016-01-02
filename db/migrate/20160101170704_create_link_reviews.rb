class CreateLinkReviews < ActiveRecord::Migration
  def change
    create_table :link_reviews do |t|
      t.text :content
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
