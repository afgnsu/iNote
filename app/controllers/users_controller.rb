class UsersController < ApplicationController
  before_action :authenticate_user!  
  before_action :require_current_user
  before_action :allow_iframe_requests, only: [:flashcard]
  
  def show
    @categories = current_user.categories.all
  end
  
  def search_link

    if params[:search_content].blank?
      params[:search_content] = ""
      @all_results = true
    else
      @all_results = false
    end
    
    @search_content = params[:search_content]
    @links_count = current_user.links.search(params[:search_content]).count 
    @links = current_user.links.search(params[:search_content]).search(params[:search_content]).page(params[:page]).per(9).order('updated_at DESC')  
  end
  
  def flashcard
    @link = current_user.links.order("RANDOM()").first
    @review = @link.link_reviews.build
    @current_reviews = @link.link_reviews.order('created_at DESC').all
    @total_review = @link.link_reviews.count
  end
  
  private
  
  def require_current_user
    if current_user != User.find_by_id(params[:id])
      flash[:danger] = "You are not the right user to do so."
      redirect_to root_path
    end   
  end
end