class UserCategoryRelationshipLinkRelationship < ActiveRecord::Base
  belongs_to :user_category_relationship
  belongs_to :link
end
