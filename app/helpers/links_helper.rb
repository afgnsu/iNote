module LinksHelper
  
  def any_reviews?(link)
    reviews = link.link_reviews
    if reviews.empty?
      false
    else
      true
    end
  end
  
  def latest_review(link)
    link.link_reviews.order("created_at DESC").limit(1).first
  end
  
  
end
