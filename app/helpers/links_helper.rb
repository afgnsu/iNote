module LinksHelper
  
  def any_reviews?(link)
    user_link_relationship = UserLinkRelationship.find_by(user: current_user, link: link)
    reviews = user_link_relationship.link_reviews
    if reviews.empty?
      false
    else
      true
    end
  end
  
  def latest_review(link)
    user_link_relationship = UserLinkRelationship.find_by(user: current_user, link: link)
    user_link_relationship.link_reviews.order("created_at DESC").limit(1).first
  end
  
  def return_review_count(link)
    user_link_relationship = UserLinkRelationship.find_by(user: current_user, link: link)
    user_link_relationship.link_reviews_count
  end
  
  
end
