module Podcast::Normalize
  class Item < Base
    attr_reader :rss_item_obj
    
    def initialize(rss_item_obj)
      raise ArgumentError.new('RSS::Rss::Channel::Item required') unless rss_item_obj.is_a? RSS::Rss::Channel::Item
      @rss_item_obj = rss_item_obj
    end
    
    def title
      plain_text(rss_item_obj.title)
    end
    
    def description
      plain_text( rss_item_obj.description )
    end
    
    def homepage
      sanitize_url(rss_item_obj.link)
    end
    
    def published_at
      pubDate
    end
    
    # duration in seconds (integer)
    def duration
      t = itunes_duration
      [ t.hour   * 3600,
        t.minute * 60,
        t.second
      ].sum
    end
    
    def media_link
      sanitize_url(enclosure.url)
    end
    
    def media_length
      enclosure.length.to_i
    rescue
      0
    end
    
    def media_type
      enclosure.type
    end
    

    # Processed attributes
    def media_audio
      # audio conversion of video
      media_link
    end

    def media_video
      # if media_type.
      media_link
    end

    # Delegate missing methods to rss_item_obj
    def method_missing(meth, *args, &block)
      rss_item_obj.send(meth, *args, &block)
    rescue NoMethodError
      super(meth, *args, &block)
    end
    
  end #Item
end #Podcast::Normalize