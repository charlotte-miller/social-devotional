require 'rss/itunes'

# Defines a common interface for all podcast formats
#
class Podcast::Channel
  include Sanitizable
  
  attr_accessor :xml_str, :podcast_obj, :items

  def initialize(xml_str)
    raise ArgumentError.new('xml_str cannot be blank') if xml_str.blank?
    @podcast_obj = RSS::Parser.parse(xml_str)
    @items       = @podcast_obj.items.map {|item| Podcast::Item.new(self, item) }
    @xml_str     = xml_str
  end

  def last_updated
    channel.lastBuildDate
  end

  def title
    plain_text(channel.title)
  end
  
  def description
    plain_text(channel.itunes_summary)
  end

  def homepage
    sanitize_url(channel.link)
  end
  
  def poster_img
    sanitize_url(channel.image.try :url)
  end
  
  def keywords
    channel.itunes_keywords.map do |keyword|
      plain_text(keyword)
    end
  end

  # original set of podcast items
  def native_rss_items
    podcast_obj.items
  end

  # Delegate missing methods to podcast_obj
  def method_missing(meth, *args, &block)
    podcast_obj.send(meth, *args, &block)
  rescue NoMethodError
    super(meth, *args, &block)
  end
  
end #Podcast::Channel

##### IF YOU HAVE PARSING PROBLEMS BETWEEN FORMATS
#  Should probably use this gem instead of rolling your own
#  - https://github.com/pauldix/feedzirra
#  - this abstracts away the various podcast providers
#####