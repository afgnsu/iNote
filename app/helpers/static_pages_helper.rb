module StaticPagesHelper
  def top_link_count(rank)
    case rank
      when 1
        "glyphicon-star-gold"
      when 2
        "glyphicon-star-silver"
      when 3 
        "glyphicon-star-bronze"
      else
        ""
    end    
  end
end
