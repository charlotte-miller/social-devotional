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

module Channels
  class Podcast < ::Channel
  
    class << self
      def pull_updates(podcasts = Podcast.all)
        podcast_arr = Array.wrap(podcasts)
      
        Podcast::Collector.new(podcast_arr) do |podcast_obj, podcast_xml|
          podcast_obj.touch(:last_checked_at)
        
          channel = Podcast::RssChannel.new(podcast_xml)
          if (channel.last_updated > podcast_obj.last_updated rescue true)
            podcast_obj.update_channel( channel )
          end
        end.run!
      end
    
    end #class << self
  

    # Areas of Responcibility
    # - podcast (self)
    # - podcast_channel
    # - studies
    # - lesson
    def update_channel( podcast_channel )
      # Process in chronological order
      new_lessons = podcast_channel.items.reverse.map do |item|
        # 0) build lesson
        lesson = Lesson.new_from_adapter( Lesson::Adapters::Podcast.new(item) )

        # 1) skip existing
        next if lesson.duplicate?

        # 2) assign or create study
        recent_studies = studies.reload.w_lessons.most_recent(5)
        study   = recent_studies.find {|study| study.should_include? lesson }
        study ||= Study.new_from_podcast_channel(podcast_channel, podcast:self).tap(&:save!)
        lesson.study = study

        # 4) save lesson
        lesson.save!
      end
    
      # 5) Update Podcast.timestamps
      touch(:last_updated) if new_lessons.any?
    
      self #chain
    end
  
    def url; build_options[:url] ;end
    def url=(url_str)
      self.build_options.merge!({url:url_str.to_s})
      url_str
    end
  
  end
  
end


# # == Schema Information
# #
# # Table name: podcasts
# #
# #  id           :integer          not null, primary key
# #  church_id    :integer          not null
# #  title        :string(100)
# #  url          :string(255)      not null
# #  last_checked :datetime
# #  last_updated :datetime
# #  created_at   :datetime         not null
# #  updated_at   :datetime         not null
# #
# 
# class Podcast < ActiveRecord::Base
#   # ---------------------------------------------------------------------------------
#   # Attributes
#   # ---------------------------------------------------------------------------------
#   attr_accessible :title, :url
#   attr_accessible :church_id, :last_checked, :last_updated, :as => :factory_girl
#   delegate :name, :homepage, :to => :church, :prefix => :church # church_name, church_homepage
# 
#   # ---------------------------------------------------------------------------------
#   # Associations
#   # ---------------------------------------------------------------------------------
#   belongs_to :church, :inverse_of => :podcasts
#   has_many :studies,  :inverse_of => :podcast do
#     def most_recent(n=nil)
#       except(:order).order('last_published_at DESC').first(n)
#     end
#   end
# 
# 
#   # ---------------------------------------------------------------------------------
#   # Validations
#   # ---------------------------------------------------------------------------------
#   validates_presence_of :church, :title, :url
# 
# 
#   # ---------------------------------------------------------------------------------
#   # Scopes
#   # ---------------------------------------------------------------------------------
# 
# 
# 
#   # ---------------------------------------------------------------------------------
#   # Methods
#   # ---------------------------------------------------------------------------------
#   class << self
#     def pull_updates(podcasts = Podcast.all)
#       podcast_arr = Array.wrap(podcasts)
#       
#       Podcast::Collector.new(podcast_arr) do |podcast_obj, podcast_xml|
#         podcast_obj.touch(:last_checked)
#         
#         channel = Podcast::Channel.new(podcast_xml)
#         if (channel.last_updated > podcast_obj.last_updated rescue true)
#           podcast_obj.update_channel( channel )
#         end
#       end.run!
#     end
#     
#   end #class << self
#   
# 
#   # Areas of Responcibility
#   # - podcast (self)
#   # - podcast_channel
#   # - studies
#   # - lesson
#   def update_channel( podcast_channel )
#     # Process in chronological order
#     new_lessons = podcast_channel.items.reverse.map do |item|
#       # 0) build lesson
#       lesson = Lesson.new_from_adapter( Lesson::Adapters::Podcast.new(item) )
# 
#       # 1) skip existing
#       next if lesson.duplicate?
# 
#       # 2) assign or create study
#       recent_studies = studies.reload.w_lessons.most_recent(5)
#       study   = recent_studies.find {|study| study.should_include? lesson }
#       study ||= Study.new_from_podcast_channel(podcast_channel, podcast:self).tap(&:save!)
#       lesson.study = study
# 
#       # 4) save lesson
#       lesson.save!
#     end
#     
#     # 5) Update Podcast.timestamps
#     touch(:last_updated) if new_lessons.any?
#     
#     self #chain
#   end
# end
