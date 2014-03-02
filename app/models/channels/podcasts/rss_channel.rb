# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  church_id       :integer          not null
#  title           :string(100)      not null
#  build_options   :text
#  last_checked_at :datetime
#  last_updated_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rss/itunes'

# Defines a common interface for all podcast formats
#

module Channels
  module Podcasts
    class RssChannel
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
  
    end #RssChannel  
  end #Podcast
end #Channels
