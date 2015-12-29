class WebsitesController < ApplicationController
  
  def index
    @websites = Website.order("count DESC").limit(10)
    @rank = 0
  end
  
end
