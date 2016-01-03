class LinksController < ApplicationController
  before_action :authenticate_user! 
  before_action :category_id_validation, only: [:quick_create]
  before_action :require_current_user, only: [:destroy]
  
  def new
    @category = Category.find(params[:category_id])
    @link = @category.links.build 
  end  

  def create
    category = Category.find(params[:category_id])
    if category.links.create(link_params)
      redirect_to user_category_path(current_user, category)
    else
      render :new
    end
  end 
  
  def destroy
    category = Category.find(params[:category_id])
    link = Link.find(params[:id])
    if link.category == category
      flash[:success] = "Link deleted!"
      link.destroy
      redirect_to :back
    else
      flash[:danger] = "This link does not belong to this category."
      redirect_to :back
    end
  end
  
  def show
    @link = Link.find(params[:id]) 
    @review = @link.link_reviews.build
    @current_reviews = @link.link_reviews.order('created_at DESC').all
  end
  
  def quick_create
    if current_user.id == params[:user_id].to_i
      if params[:link][:category_id].to_i > 0 # add to one of current categories 
        old_category = current_user.categories.find(params[:link][:category_id])  
        if old_category.nil? # not the current user's category
          flash[:danger] = "You cannot add link for others!"      
          redirect_to root_path          
        else
          old_category.links.create(link_params)    
        end
      else # want to add to "Unclassified"
        unclassified_category = current_user.categories.find_by(name: "Unclassified") 
        if unclassified_category.nil?
          unclassified_category = current_user.categories.create(name: "Unclassified", private: true)
        end
        
        unclassified_category.links.create(link_params)
      end
      
      flash[:success] = "linked!" 
      redirect_to :back
      
    else
      flash[:danger] = "You cannot add link for others!"      
      redirect_to root_path
    end
  end
  
  private
    def link_params
      params.require(:link).permit(:title, :description, :link)
    end
    
    def category_id_validation
      if is_numeric(params[:link][:category_id]) == true   
        if params[:link][:category_id].to_i < 0
          flash[:danger] = "Wrong operation!"
          redirect_to root_path          
        end
      else # nil is not a number, too
        flash[:danger] = "Wrong operation!"
        redirect_to root_path
      end
    end

    def require_current_user
      if current_user != User.find(params[:user_id])
        flash[:danger] = "You are not the right user to do so."
        redirect_to root_path
      end
    end      

end
