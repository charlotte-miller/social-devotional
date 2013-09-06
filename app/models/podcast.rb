# == Schema Information
#
# Table name: podcasts
#
#  id           :integer          not null, primary key
#  church_id    :integer          not null
#  title        :string(100)
#  url          :string(255)      not null
#  last_checked :datetime
#  last_updated :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Podcast < ActiveRecord::Base
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :title, :url
  attr_accessible :church_id, :last_checked, :last_updated, :as => :factory_girl
  delegate :name, :homepage, :to => :church, :prefix => :church # church_name, church_homepage

  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :church, :inverse_of => :podcasts
  has_many :studies,  :inverse_of => :podcast do
    def most_recent(n=nil)
      order('last_published_at ASC').last(n)
    end
  end


  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :church, :title, :url


  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------



  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  class << self
    def pull_updates(podcasts = Podcast.all)
      podcast_arr = Array.wrap(podcasts)
      
      Podcast::Collector.new(podcast_arr) do |podcast_obj, podcast_xml|
        podcast_obj.touch(:last_checked)
        
        channel = Podcast::Normalize::Channel.new(podcast_xml)
        if channel.last_updated > podcast_obj.last_updated
          podcast_obj.update_channel( channel )
        end
      end.run!
    end
    
  end #class << self
  

  # Areas of Responcibility
  # - podcast (self)
  # - normalized_channel
  # - studies
  # - lesson
  def update_channel( normalized_channel )
    normalized_channel.items.each do |item|  
      # 0) build lesson
      lesson = Lesson.new_from_podcast_item(item)

      # 1) skip existing
      recent_studies = studies.w_lessons.most_recent(5)
      last_lessons   = recent_studies.map {|study| study.lessons.last }
      is_duplicate   = last_lessons.any? {|last_lesson| last_lesson.duplicate? lesson }
      return self if is_duplicate

      # 2) assign or create study
      study   = recent_studies.find {|study| study.should_include? lesson }
      study ||= Study.new_from_podcast_channel(normalized_channel, podcast:self).tap(&:save!)
      lesson.study = study

      # 4) save lesson
      lesson.save!
    end
    
    # 5) Update Podcast.timestamps
    touch(:last_updated)
    
    self #chain
  end
end
