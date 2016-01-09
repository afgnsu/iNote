class CategoryLinkRelationship < ActiveRecord::Base
  belongs_to :category, counter_cache: :links_count
  belongs_to :link, counter_cache: :categories_count
end
