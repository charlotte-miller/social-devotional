# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  study_id           :integer          not null
#  position           :integer          default(0)
#  title              :string(255)      not null
#  description        :text
#  backlink           :string(255)
#  video_file_name    :string(255)
#  video_content_type :string(255)
#  video_file_size    :integer
#  video_updated_at   :datetime
#  video_original_url :string(255)
#  audio_file_name    :string(255)
#  audio_content_type :string(255)
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  audio_original_url :string(255)
#  machine_sorted     :boolean          default(FALSE)
#  duration           :integer
#  published_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lesson < ActiveRecord::Base
  include AttachableFile
  include Searchable
  include Questionable
  # include Comparable
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  # http://rubydoc.info/github/FriendlyId/friendly_id/master/FriendlyId/Scoped
  # extend FriendlyId
  # friendly_id :position, :use => :scoped, :scope => :study
  
  acts_as_list scope: :study

  attr_accessible :study, :study_id, :position, :title, :description, :backlink, :published_at, :machine_sorted,
                  :audio, :video, :audio_remote_url, :video_remote_url

  attr_accessible *column_names, :study, :audio_remote_url, :video_remote_url, as: 'sudo'
  
  delegate :title, :to => :study, prefix:true  # study_title
  
  has_attachable_file :audio, :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension'  
  has_attachable_file :video, :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension'
  
  # has_attached_file :video, :styles => {
  #      :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
  #      :medium => { :geometry => "640x480", :format => 'flv' }
  #      :mobile => {:geometry => "400x300", :format => 'mp4', :streaming => true}
  #   }, :processors => [:ffmpeg, :qtfaststart]

  # http://sunspot.github.com/
  searchable do
    string( :title  )      { searchable_title title        }
    string( :study_title ) { searchable_title study.title }
    text    :description
  end 
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :study, touch:true, :inverse_of => :lessons     # counter_cache rolled into Study#touch
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :study, :title
  # validates_uniqueness_of :position, :scope => :study_id
  # validates_attachment_presence :audio, :video
  
  # http://stackoverflow.com/questions/3181845/validate-attachment-content-type-paperclip
  # validates_attachment_content_type :audio
  
  
  # ---------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_study, lambda {|study_id| where({ study_id: study_id }) }
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  class << self
    
    # Builds a @lesson from a Podcast::Normalize::Item
    # WARN Study must be added later
    def new_from_podcast_item(podcast_item)
      lesson = new({
        :study            => nil,
        :title            => podcast_item.title,
        :description      => podcast_item.description,
        :backlink         => podcast_item.homepage,
        :published_at     => podcast_item.published_at,
        :duration         => podcast_item.media_length,
        :audio_remote_url => podcast_item.media_audio,
        :video_remote_url => podcast_item.media_video,
      }, as:'sudo')
    end
    
  end
  
  # Determins how similar a lesson is to the other_lesson
  # Loops through an array of heuristics looking for a match (stops after match)
  # => returns true|false
  #
  def belongs_with? other_lesson
    require 'lesson/similarity_heuristic/base'
    !!Lesson::SimilarityHeuristic::Base::STRATEGIES.find do |strategy|
      strategy.new(self, other_lesson).matches?
    end
  end
  
  def duplicate?
    Lesson.where(backlink: backlink).exists?
  end
end
