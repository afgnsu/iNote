class StaticPagesController < ApplicationController
  def home
    unless current_user.nil?
      @link = Link.new
      @categories = current_user.categories
    end
  end
end
