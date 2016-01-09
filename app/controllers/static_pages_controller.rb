class StaticPagesController < ApplicationController
  
  def top_links
    @links = Link.where("users_count > 1").order("users_count DESC").limit(10)  
    @rank = 0
  end
  
  def home
  
  end
  
end
