class LongurlService
  
  SHORTEN_SERVICES = %w("bit.do" "goo.gl" "bitly.com" "tinyurl.com" "bit.ly")
  
  def initialize(link)
    @link = link
  end 
  
  def expand_url 
    @link = unescape(@link)  
    @link = encode(@link)  
    @link = check_protocol(@link)
    @link = expand(@link)
  end
  

  private
  
    def unescape(url)
      URI::unescape(url)
    end
    
    def encode(url)
      URI::encode(url)
    end

    def check_protocol(url)
      if url.exclude? "http://" and url.exclude? "https://" 
        "http://#{url}"
      else
        url
      end
    end
    
    def expand(url)
      if SHORTEN_SERVICES.any?{ |s| s[URI(url).host] }
        url = LongURL.expand(url)
      else
        url
      end        
    end
    
end