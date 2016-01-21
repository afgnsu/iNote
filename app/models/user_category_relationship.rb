class UserCategoryRelationship < ActiveRecord::Base
  belongs_to :user, counter_cache: :categories_count
  belongs_to :category, counter_cache: :users_count
  has_many :user_category_relationship_link_relationships
  has_many :links, through: :user_category_relationship_link_relationships
end
