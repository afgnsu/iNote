class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @category = current_user.categories.build
  end
  
  def create
    @user = User.find(params[:user_id])
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
      @category = Category.find(params[:id])
      @links = @category.links.order('updated_at ASC').all
      @sort_now = "oldest"
    else #newest
      @category = Category.find(params[:id])
      @links = @category.links.order('updated_at DESC').all    
      @sort_now = "newest"
    end
    
    session[:sort] = @sort_now
  end
  
  def flashcard
    @category = Category.find(params[:id])
    @link = @category.links.order("RANDOM()").first
  end
  
  private
    
    def category_params 
      params.require(:category).permit(:name, :private)
    end
end
