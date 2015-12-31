class Category < ActiveRecord::Base
  belongs_to :user
  has_many :links, :dependent => :destroy
  validates :name, presence: true
  
end
