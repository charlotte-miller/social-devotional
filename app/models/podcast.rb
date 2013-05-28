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
  attr_accessible :church_id, :last_checked, :title, :url
  delegate :name, :homepage, :to => :church, :prefix => :church # church_name, church_homepage

  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :church#, :inverse_of => :podcast
  has_many :studies do #,  :inverse_of => :podcast
    def most_recent
      order('last_published_at ASC').last
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
        channel = Podcast::Normalize::Channel.new(podcast_xml)
        if channel.last_updated > podcast_obj.last_updated
          podcast_obj.update_channel( channel )
        end
      end.run!
    end
    
  end #class << self
  
  def update_channel( normalized_channel )
    self.studies.most_recent
    Study.update_from_channel()
  end
end
