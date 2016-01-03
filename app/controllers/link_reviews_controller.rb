class LinkReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    link = Link.find(params[:link_id])
    if link.link_reviews.create(link_review_params)
      redirect_to :back
    else
      flash[:danger] = "Failed to add review!"
      redirect_to :back
    end
  end
  
  private
  
  def link_review_params
    params.require(:link_review).permit(:content)
  end
end
