class UserLinkRelationship < ActiveRecord::Base
  has_many :link_reviews, :dependent => :destroy
  belongs_to :user, counter_cache: :links_count
  belongs_to :link, counter_cache: :users_count
end
