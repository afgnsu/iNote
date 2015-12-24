class UsersController < ApplicationController
  before_action :authenticate_user!  
  
  def show
    @categories = current_user.categories.all
  end

end