class NotesController < ApplicationController
  before_action :authenticate_user! 
  before_action :category_id_validation, only: [:quick_create]
  
  def new
    @category = Category.find(params[:category_id])
    @note = @category.notes.build 
  end  

  def create
    category = Category.find(params[:category_id])
    if category.notes.create(note_params)
      redirect_to user_category_path(current_user, category)
    else
      render :new
    end
  end 
  
  def quick_create
    if current_user.id == params[:user_id].to_i
      if params[:note][:category_id].to_i > 0 # add to one of current categories 
        old_category = current_user.categories.find(params[:note][:category_id])  
        if old_category.nil? # not the current user's category
          flash[:danger] = "You cannot add note for others!"      
          redirect_to root_path          
        else
          old_category.notes.create(note_params)    
        end
      else # want to add to "Unclassified"
        unclassified_category = current_user.categories.find_by(name: "Unclassified") 
        if unclassified_category.nil?
          unclassified_category = current_user.categories.create(name: "Unclassified", private: true)
        end
        
        unclassified_category.notes.create(note_params)
      end
      
      flash[:success] = "Noted!" 
      redirect_to root_path
      
    else
      flash[:danger] = "You cannot add note for others!"      
      redirect_to root_path
    end
  end
  
  private
    def note_params
      params.require(:note).permit(:title, :description, :link)
    end
    
    def category_id_validation
      if is_numeric(params[:note][:category_id]) == true   
        if params[:note][:category_id].to_i < 0
          flash[:danger] = "Wrong operation!"
          redirect_to root_path          
        end
      else # nil is not a number, too
        flash[:danger] = "Wrong operation!"
        redirect_to root_path
      end
    end

end
