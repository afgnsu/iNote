class AddLinkReviewsCountToUserLinkRelationship < ActiveRecord::Migration
  def change
    add_column :user_link_relationships, :link_reviews_count, :integer, null: false, default: 0
  end
end
