class ChangeLinkIdToUserLinkRelationshipIdInLinkreviews < ActiveRecord::Migration
  def change
    rename_column :link_reviews, :link_id, :user_link_relationship_id
  end
end
