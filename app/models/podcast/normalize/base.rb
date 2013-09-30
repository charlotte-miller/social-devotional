require 'rss/itunes'
require 'uri'

module Podcast::Normalize
  class Base ;protected
    
    def plain_text(str)
      str = ActionController::Base.helpers.sanitize(str)    #rm script && style
      str.to_s.gsub!(/>\s*</,'> <')                         #single space between tags
      str = ActionController::Base.helpers.strip_tags(str)  #rm tags
      str.to_s.strip                                        #rm padding/whitespace
    end
    
    def sanitize(str)
      ActionController::Base.helpers.sanitize(str).strip
    end

    def sanitize_url(url)
      uri = URI.parse(url)
      raise URI::InvalidURIError unless uri.kind_of?(URI::HTTP)
      uri.to_s
    rescue URI::InvalidURIError
      nil
    end
    
  end #Base
end #Podcast::Normalize