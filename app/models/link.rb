class Link < ActiveRecord::Base
  before_save :full_link
  before_save :add_link_information
  before_save :add_website
  belongs_to :category, :counter_cache => true
  belongs_to :website, :counter_cache => true
  has_many :link_reviews, :dependent => :destroy
  
  def self.search(input)
    where( "link_title LIKE ? or link_description LIKE ?", "%#{input}%", "%#{input}%")
  end  
  
  private
  
  def full_link
    if link.exclude? "http://" and link.exclude? "https://" 
      self.link = "http://#{link}"
    end
      self.link = URI::encode(self.link)
  end
  
  def add_link_information
    object = LinkThumbnailer.generate(link)
    if ! object.nil?
      self.link_title = object.title
      self.link_description = object.description
      if object.images.length != 0 
        self.link_picture = object.images.first.src.to_s
      end
    end
  end
  
  def add_website
    uri = URI(link)
    website = Website.find_by(host: uri.host)
    if website.nil?
      object = LinkThumbnailer.generate("#{uri.scheme}://#{uri.host}")  
      website = Website.create(host: uri.host, scheme: uri.scheme, title: object.title)
      #website = Website.create(host: uri.host, scheme: uri.scheme, title: object.title, count: 1)
      self.website = website
    else
      self.website = website
    end
  end
end
