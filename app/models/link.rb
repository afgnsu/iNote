class Link < ActiveRecord::Base
  before_save :full_link
  before_save :add_link_information
  before_save :increase_website_count
  belongs_to :category, :counter_cache => true
  
  private
  
  def full_link
    if link.exclude? "http://" and link.exclude? "https://" 
      self.link = "http://#{link}"
    end
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
  
  def increase_website_count
    uri = URI(link)
    website = Website.find_by(host: uri.host)
    if website.nil?
      object = LinkThumbnailer.generate("#{uri.scheme}://#{uri.host}")  
      Website.create(host: uri.host, scheme: uri.scheme, title: object.title, count: 1)
    else
      Website.increment_counter(:count, website.id)
    end
  end
end
