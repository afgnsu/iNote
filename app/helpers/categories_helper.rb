module CategoriesHelper
  def link_sort_active(sort_now,sort_option)
    "link-disable" if sort_now == sort_option
  end
  
  def li_active(now_option, li_option)
    "active" if now_option == li_option
  end
  
  def created_time_link_category(link, category)
    CategoryLinkRelationship.find_by(category: category, link: link).created_at
  end
end
