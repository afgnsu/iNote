class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_user
  before_action :require_current_category, only: [:show]
  before_filter :allow_iframe_requests, only: [:flashcard]
  
  def new
    @category = current_user.categories.build
  end
  
  def create
    @user = User.find_by_id(params[:user_id])
    if @user.categories.create(category_params)
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    session[:sort] = params[:sort] if params[:sort] != nil   
    
    case session[:sort]
    when "oldest"
      @category = Category.find_by_id(params[:id])
      @links = @category.links.page(params[:page]).per(9).order('updated_at ASC')
      @sort_now = "oldest"
    else #newest
      @category = Category.find_by_id(params[:id])
      @links = @category.links.page(params[:page]).per(9).order('updated_at DESC')   
      @sort_now = "newest"
    end
    
    session[:sort] = @sort_now
  end
  
  def flashcard
    @category = Category.find_by_id(params[:id])
    @link = @category.links.order("RANDOM()").first
    @review = @link.link_reviews.build
    @current_reviews = @link.link_reviews.order('created_at DESC').all
    @total_review = @link.link_reviews.count    
  end
  
  private
    
    def category_params 
      params.require(:category).permit(:name, :private)
    end
    
    def require_current_user
      if current_user != User.find_by_id(params[:user_id])
        flash[:danger] = "You are not the right user to do so."
        redirect_to root_path
      end
    end  

    def require_current_category
      if current_user.categories.find_by_id(params[:id]).nil?
        flash[:danger] = "You are not the right user to do so."
        redirect_to root_path
      end
    end        

end
