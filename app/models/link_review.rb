class LinkReview < ActiveRecord::Base
  belongs_to :user_link_relationship, :counter_cache => true
end
