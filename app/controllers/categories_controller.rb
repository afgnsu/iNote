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
    @category = Category.find_by_id(params[:id])
    user_category_relationship = UserCategoryRelationship.find_by(user: current_user, category: @category)
    case session[:sort]
    when "oldest"
      #@links = @category.links.page(params[:page]).per(9).order('updated_at ASC')
      @links = Link.joins(:user_category_relationship_link_relationships).where("user_category_relationship_link_relationships.user_category_relationship_id = #{user_category_relationship.id}").page(params[:page]).per(9).order("user_category_relationship_link_relationships.created_at ASC")
      @sort_now = "oldest"
    else #newest
      #@links = @category.links.page(params[:page]).per(9).order('updated_at DESC')   
      @links = Link.joins(:user_category_relationship_link_relationships).where("user_category_relationship_link_relationships.user_category_relationship_id = #{user_category_relationship.id}").page(params[:page]).per(9).order("user_category_relationship_link_relationships.created_at DESC")
      @sort_now = "newest"
    end
    
    session[:sort] = @sort_now
    
  end
  
  def flashcard
    @category = Category.find_by_id(params[:id])
    user_category_relationship = UserCategoryRelationship.find_by(user: current_user, category: @category)
    @link = user_category_relationship.links.order("RANDOM()").first
    user_link_relationship = UserLinkRelationship.find_by(user: current_user, link: @link)
    @read = user_link_relationship.read
    @review = user_link_relationship.link_reviews.build
    @current_reviews = user_link_relationship.link_reviews.order('created_at DESC').all
    @total_review = user_link_relationship.link_reviews.count  
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
