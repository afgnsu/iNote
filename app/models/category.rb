class Category < ActiveRecord::Base
  belongs_to :user
  
  def new
    @category = current_user.categories.build
  end
  
  def create
  end
  
end
