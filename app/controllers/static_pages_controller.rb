class StaticPagesController < ApplicationController
  def home
    unless current_user.nil?
      @note = Note.new
      @categories = current_user.categories
    end
  end
end
