require 'rss/itunes'

# Defines a common interface for all podcast formats
#
class Podcast::Item
  include Sanitizable
  
  attr_reader :parent_channel, :rss_item_obj
  
  def initialize(parent_channel, rss_item_obj)
    raise ArgumentError.new('Podcast::Channel required') unless parent_channel.is_a? Podcast::Channel
    raise ArgumentError.new('RSS::Rss::Channel::Item required') unless rss_item_obj.is_a? RSS::Rss::Channel::Item
    @parent_channel = parent_channel
    @rss_item_obj   = rss_item_obj
  end
  
  def title
    plain_text(rss_item_obj.title)
  end
  
  def author
    plain_text( rss_item_obj.try_these(:author, :itunes_author) )
  end
  
  def description
    plain_text( rss_item_obj.try_these(:description, :itunes_summary) )
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
  
  # TODO: split audio from video OR handle audio only
  def media_audio
    # audio conversion of video
    media_link
  end

  def media_video
    # if media_type.
    media_link
  end
  
  def poster_img
    parent_channel.poster_img
  end

  # Delegate missing methods to rss_item_obj
  def method_missing(meth, *args, &block)
    rss_item_obj.send(meth, *args, &block)
  rescue NoMethodError
    super(meth, *args, &block)
  end

end #Podcast::Item