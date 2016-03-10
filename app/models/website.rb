class Website < ActiveRecord::Base
  has_many :links, :dependent => :destroy
  scope :recent, -> { order("links_count DESC").limit(10) }
  
end
