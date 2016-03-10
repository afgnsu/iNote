class WebsitesController < ApplicationController
  
  def index
    @websites = Website.recent
    @rank = 0
  end
  
end
