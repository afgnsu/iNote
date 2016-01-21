module CategoriesHelper
  def link_sort_active(sort_now,sort_option)
    "link-disable" if sort_now == sort_option
  end
  
  def li_active(now_option, li_option)
    "active" if now_option == li_option
  end
  
  def created_time_link_category(link, category)
    user_category_relationship = UserCategoryRelationship.find_by(user: current_user, category: category)
    UserCategoryRelationshipLinkRelationship.find_by(user_category_relationship: user_category_relationship, link: link).created_at
  end
end
