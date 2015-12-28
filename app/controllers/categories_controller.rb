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
    @category = Category.find(params[:id])
    @notes = @category.notes.all           
  end
  
  private
    
    def category_params 
      params.require(:category).permit(:name, :private)
    end
end
