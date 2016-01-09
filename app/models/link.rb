class Link < ActiveRecord::Base
  before_save :full_link
  before_save :add_link_information
  before_save :add_website
  belongs_to :category, :counter_cache => true
  belongs_to :website, :counter_cache => true
  has_many :users, through: :user_link_relationships 
  has_many :user_link_relationships, :dependent => :destroy
  has_many :categories, through: :category_link_relationships 
  has_many :category_link_relationships , :dependent => :destroy  
  

  @@shorten_services = %w("bit.do" "goo.gl" "bitly.com" "tinyurl.com" "bit.ly") 
  
  def self.search(input)
    where( "link_title LIKE ? or link_description LIKE ?", "%#{input}%", "%#{input}%")
  end  
  
  private
  
  def full_link
    if link.exclude? "http://" and link.exclude? "https://" 
      self.link = "http://#{link}"
    end
    
    # for shorten URL
    uri = URI(self.link)
    if @@shorten_services.any?{ |s| s[uri.host] }
      self.link = LongURL.expand(self.link)
    end
    
    self.link = URI::unescape(self.link)
    self.link = URI::encode(self.link)
  
  end
  
  def add_link_information
    object = LinkThumbnailer.generate(link)
    if ! object.nil?
      self.link_title = object.title
      self.link_description = object.description
      if object.images.length != 0 
        if object.images.first.src.to_s.include?("www.flickr.com")
          object = LinkThumbnailer.generate(object.images.first.src.to_s) 
        end
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
