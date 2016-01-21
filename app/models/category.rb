class Category < ActiveRecord::Base
  has_many :links, through: :category_link_relationships 
  has_many :category_link_relationships , :dependent => :destroy
  has_many :users, through: :user_category_relationships
  has_many :user_category_relationships, :dependent => :destroy  
  validates :name, presence: true
  
  def link_count_of(user)
    user_category_relationship = UserCategoryRelationship.find_by(user: user, category: self)
    user_category_relationship.links.count
  end
  
end
