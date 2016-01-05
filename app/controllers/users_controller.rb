class UsersController < ApplicationController
  before_action :authenticate_user!  
  before_action :allow_iframe_requests, only: [:flashcard]
  
  def show
    @categories = current_user.categories.all
  end
  
  def flashcard
    @link = Link.where(category_id: Category.where(user_id: params[:id])).order("RANDOM()").first
    @review = @link.link_reviews.build
    @current_reviews = @link.link_reviews.order('created_at DESC').all
    @total_review = @link.link_reviews.count
  end
end