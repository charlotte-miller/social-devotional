module Podcast::Normalize
  class Item < Base
    attr_reader :rss_item_obj
    
    def initialize(rss_item_obj)
      raise ArgumentError.new('RSS::Rss::Channel::Item required') unless rss_item_obj.is_a? RSS::Rss::Channel::Item
      @rss_item_obj = rss_item_obj
    end
    
    
    # Delegate missing methods to rss_item_obj
    def method_missing(meth, *args, &block)
      rss_item_obj.send(meth, *args, &block)
    rescue NoMethodError
      super(meth, *args, &block)
    end
    
  end #Item
end #Podcast::Normalize