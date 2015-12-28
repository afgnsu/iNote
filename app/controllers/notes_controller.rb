class NotesController < ApplicationController
  before_action :authenticate_user!  
  
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
  
  def note_params
    params.require(:note).permit(:title, :description, :link)
  end
end
