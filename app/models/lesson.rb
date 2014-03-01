# == Schema Information
#
# Table name: lessons
#
#  id                      :integer          not null, primary key
#  study_id                :integer          not null
#  position                :integer          default(0)
#  stars_count             :integer          default(0)
#  title                   :string(255)      not null
#  description             :text
#  author                  :string(255)
#  backlink                :string(255)
#  poster_img_file_name    :string(255)
#  poster_img_content_type :string(255)
#  poster_img_file_size    :integer
#  poster_img_updated_at   :datetime
#  poster_img_original_url :string(255)
#  poster_img_fingerprint  :string(255)
#  video_file_name         :string(255)
#  video_content_type      :string(255)
#  video_file_size         :integer
#  video_updated_at        :datetime
#  video_original_url      :string(255)
#  video_fingerprint       :string(255)
#  audio_file_name         :string(255)
#  audio_content_type      :string(255)
#  audio_file_size         :integer
#  audio_updated_at        :datetime
#  audio_original_url      :string(255)
#  audio_fingerprint       :string(255)
#  machine_sorted          :boolean          default(FALSE)
#  duration                :integer
#  published_at            :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Lesson < ActiveRecord::Base
  include Searchable
  include Questionable
  include Lesson::AttachedMedia
  # include Comparable

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  # http://rubydoc.info/github/FriendlyId/friendly_id/master/FriendlyId/Scoped
  # extend FriendlyId
  # friendly_id :position, :use => :scoped, :scope => :study
  delegate :title, :to => :study, prefix:true  # study_title
  acts_as_list scope: :study

  # Private 'sudo' access to everything
  attr_accessible *column_names, :study, :audio_remote_url, :video_remote_url, :poster_img, :poster_img_remote_url, as: 'sudo'
  
  # Public
  attr_accessible :study, :study_id, :position, :title, :author, :description, :backlink, :published_at, :machine_sorted,
                  :audio, :video, :poster_img, :audio_remote_url, :video_remote_url, :poster_img_remote_url


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
  # has_one :poster_maker, :class_name => "Lesson::PosterMaker", :dependent => :destroy
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :study, :title, :author
  # validates_uniqueness_of :position, :scope => :study_id
  # validates_attachment_presence :audio, :video
  
  # http://stackoverflow.com/questions/3181845/validate-attachment-content-type-paperclip
  # validates_attachment_content_type :video, :audio
  
  
  # ---------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------
  before_save :process_poster_img_first # Lesson::AttachedMedia
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_study, lambda {|study_id| where({ study_id: study_id }) }
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  class << self
      
    # Builds a lesson from an instance of Lesson::Adapters::'Klass'
    # WARN Study must be added later
    def new_from_adapter(lesson_adapter)
      church     = Church.where(homepage: URI(lesson_adapter.url).host).first
      attributes = lesson_adapter.to_hash
      study_str  = attributes.delete :study_title
      _lesson = new(attributes, as:'sudo')
      _lesson.study = Study.find_or_create_by_title({title:study_str, church:church}, as:'sudo') #rails4 upgrade
      _lesson.save!
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
