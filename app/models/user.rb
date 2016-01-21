class User < ActiveRecord::Base

  has_many :links, through: :user_link_relationships 
  has_many :user_link_relationships, :dependent => :destroy
  has_many :categories, through: :user_category_relationships
  has_many :user_category_relationships, :dependent => :destroy  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :associate_to_default_categories    
  
  private
    def associate_to_default_categories
      Category.all.where(predefined: true).each do |category|
        self.categories << category
      end
    end
end
