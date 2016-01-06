class UsersController < ApplicationController
  before_action :authenticate_user!  
  before_action :allow_iframe_requests, only: [:flashcard]
  
  def show
    @categories = current_user.categories.all
  end
  
  def search_link
    if current_user != User.find(params[:id])
      flash[:danger] = "You are not the right user to do so."
      redirect_to root_path
    end 
    
    if params[:search_content].blank?
      params[:search_content] = ""
      @all_results = true
    else
      @all_results = false
    end
    
    @search_content = params[:search_content]
    @links_count = Link.where(category_id: Category.where(user_id: params[:id])).search(params[:search_content]).count 
    @links = Link.where(category_id: Category.where(user_id: params[:id])).search(params[:search_content]).page(params[:page]).per(9).order('updated_at DESC')  
  end
  
  def flashcard
    @link = Link.where(category_id: Category.where(user_id: params[:id])).order("RANDOM()").first
    @review = @link.link_reviews.build
    @current_reviews = @link.link_reviews.order('created_at DESC').all
    @total_review = @link.link_reviews.count
  end
end