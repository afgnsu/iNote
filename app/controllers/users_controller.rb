class UsersController < ApplicationController
  before_action :authenticate_user!  
  
  def show
    @categories = current_user.categories.all
  end
  
  def flashcard
    @note = Note.where(category_id: Category.where(user_id: params[:id])).order("RANDOM()").first
  end

end