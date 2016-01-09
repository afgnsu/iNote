class LinkReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user_link_relationship = UserLinkRelationship.where(user_id: current_user.id, link_id: params[:link_id]).first
    if user_link_relationship.link_reviews.create(link_review_params)
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
