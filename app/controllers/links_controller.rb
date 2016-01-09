class LinksController < ApplicationController
  before_action :authenticate_user! 
  before_action :category_id_validation, only: [:create]
  before_action :require_current_user, only: [:new, :show, :destroy, :create]
  before_action :allow_iframe_requests, only: [:show]
  
  @@shorten_services = %w("bit.do" "goo.gl" "bitly.com" "tinyurl.com" "bit.ly") 
  
  def new
    @link = Link.new
  end  

  def create
    if params[:link][:link].exclude? "http://" and params[:link][:link].exclude? "https://" 
      params[:link][:link] = "http://#{params[:link][:link]}"
    end
    
    # for shorten URL
    params[:link][:link] = URI::unescape(params[:link][:link])
	  params[:link][:link] = URI::encode(params[:link][:link])    
    uri = URI(params[:link][:link])
    if @@shorten_services.any?{ |s| s[uri.host] }
      params[:link][:link] = LongURL.expand(params[:link][:link])
    end
    
    if params[:category_id].to_i > 0 # add to one of current categories 
      # if the category belongs to current user
      category = current_user.categories.find_by_id(params[:category_id])   
      if category.nil?
        flash[:danger] = "This category is not yours or not existed."
        redirect_to root_path      
      end
    else
      category = current_user.categories.find_by(name: "Unclassified")  
      if category.nil?
        category = current_user.categories.create(name: "Unclassified", private: true)
      end      
    end
    
    exist_link_of_all = Link.find_by(link: params[:link][:link])
    if exist_link_of_all.nil?
      if new_link = category.links.create(link_params)
        UserLinkRelationship.create(user: current_user, link: new_link)
        flash[:success] = "linked! <a href='#{user_link_path(current_user, new_link)}'>See it!</a>"
        redirect_to :back
      else
        flash[:danger] = "Something wrong!"
        render :new
      end            
    else
      exist_link_of_user_category = category.links.find_by(link: params[:link][:link])
      if exist_link_of_user_category.nil?
        exist_link_of_user_other_category = current_user.links.find_by(link: params[:link][:link])
        if exist_link_of_user_other_category.nil? 
          UserLinkRelationship.create(user: current_user, link: exist_link_of_all)
        end
        CategoryLinkRelationship.create(category: category, link: exist_link_of_all)
        flash[:success] = "linked! <a href='#{user_link_path(current_user, exist_link_of_all)}'>See it!</a>"
        redirect_to :back       
      else
        flash[:danger] = "You created this link in this category before!"
        redirect_to user_link_path(current_user, exist_link_of_user_category)                 
      end
    end
  end 
  
  def destroy
    category = current_user.categories.find_by_id(params[:category_id])   
    if category.nil?
      flash[:danger] = "This category is not yours or not existed."
      redirect_to root_path      
    end

    link = current_user.links.find_by_id(params[:id])
    if ! link.nil? 
      flash[:success] = "Link deleted!"
      CategoryLinkRelationship.where(category_id: category.id, link_id: link.id).first.destroy
      exist_category_has_link = link.categories.joins(:users).merge(User.where(id: current_user.id)).first
      if exist_category_has_link.nil?
        UserLinkRelationship.where(user: current_user, link: link).first.destroy
      end
      
      link.reload
      if link.users_count == 0
        link.destroy
      end
      redirect_to :back
    else
      flash[:danger] = "You don't have this link!"
      redirect_to root_path
    end
    
  end
  
  def show
 
    user_link_relationship = UserLinkRelationship.where(user_id: current_user.id, link_id: params[:id]).first
    if user_link_relationship.nil?
      flash[:danger] = "Wrong operation!"
      redirect_to root_path and return      
    end  
    
    @link = Link.find_by_id(params[:id]) 
    @review = user_link_relationship.link_reviews.build
    @current_reviews = user_link_relationship.link_reviews.order('created_at DESC').all
    @total_review = user_link_relationship.link_reviews.count
  end
  
  private
    def link_params
      params.require(:link).permit(:title, :description, :link)
    end
    
    def category_id_validation
      if is_numeric(params[:category_id]) == true   
        if params[:category_id].to_i < 0
          flash[:danger] = "Wrong operation!"
          redirect_to root_path          
        end
      else # nil is not a number, too
        flash[:danger] = "Wrong operation!"
        redirect_to root_path
      end
    end

    def require_current_user
      if current_user != User.find_by_id(params[:user_id])
        flash[:danger] = "You are not the right user to do so."
        redirect_to root_path
      end
    end      

end
