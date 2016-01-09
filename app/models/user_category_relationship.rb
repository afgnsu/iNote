class UserCategoryRelationship < ActiveRecord::Base
  belongs_to :user, counter_cache: :categories_count
  belongs_to :category, counter_cache: :users_count
end
