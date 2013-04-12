# Normalizes Podcasts into a standard interface
# require 'rss/parser'
require 'rss/itunes'


class Podcast::Parser
  attr_accessor :xml_str, :podcast_obj
  
  def initialize(xml_str)
    raise ArgumentError.new('xml_str cannot be blank') if xml_str.blank?
    @xml_str = xml_str
    @podcast_obj  = RSS::Parser.parse(xml_str)
  end
  
  def last_updated
    channel.lastBuildDate
  end
  
  # Delegate missing methods to podcast_obj
  def method_missing(meth, *args, &block)
    podcast_obj.send(meth, *args, &block)
  rescue
    super(meth, *args, &block)
  end
  
private

  def sanitize(str)
    ActionController::Base.helpers.sanitize(str)
  end
  
end

##### IF YOU HAVE PARSING PROBLEMS BETWEEN FORMATS
#  Should probably use this gem instead of rolling your own
#  - https://github.com/pauldix/feedzirra
#  - this abstracts away the various podcast providers
#####