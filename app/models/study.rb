# == Schema Information
#
# Table name: studies
#
#  id                      :integer          not null, primary key
#  slug                    :string(255)      not null
#  podcast_id              :integer          not null
#  title                   :string(255)      not null
#  description             :string(255)
#  ref_link                :string(255)
#  poster_img_file_name    :string(255)
#  poster_img_content_type :string(255)
#  poster_img_file_size    :integer
#  poster_img_updated_at   :datetime
#  poster_img_original_url :string(255)
#  poster_img_fingerprint  :string(255)
#  keywords                :text             default(""), not null
#  lessons_count           :integer          default(0)
#  last_published_at       :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Study < ActiveRecord::Base
  include Sluggable
  include Searchable
  include AttachableFile
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :title, :description, :ref_link,  :poster_img, :poster_img_remote_url, :podcast, :podcast_id
  attr_accessible *column_names, *reflections.keys, :poster_img, :poster_img_remote_url, :podcast, :podcast_id, as: 'sudo'
  delegate :church_name, to: :podcast
  serialize :keywords
  
  friendly_id :title #remove after v 5.0.0
  slug_candidates :title, [:title, :church_name]
  
  has_attachable_file :poster_img, path: ':rails_env/:class/:attachment/:id/:hash.:extension',
                      :hash_data => ":class/:attachment/:id/:fingerprint-:style",
                      :url => AppConfig.domains.cdn
                      # :styles => { thumb: { geometry: SD_SIZE, format: 'png', convert_options: "-strip" }}
                      # :processors => [:thumbnail, :pngquant]

  # http://sunspot.github.com/
  searchable do
    string(  :title)                { searchable_title title } #, boost: 2.0 
    string(  :lesson_title    )     { searchable_title lessons.select(:title).map(&:title).join(' | ') }
    text     :description
    string(  :church_name     )     { church_name       }
    integer( :church_id       )     { podcast.church_id }
    # string(  :tags          )     { tags.select(:text).map(&:text).join(' | ')}
  end
  
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :podcast, :inverse_of => :studies
  has_one :church,     :through => :podcast, :inverse_of => :studies
  has_many :lessons, :order => 'position ASC', :dependent => :destroy, :inverse_of => :study do
    def number(n, strict=false)
      raise ActiveRecord::RecordNotFound if strict && (n > self.length) #lessons_count
      where(position:n).first
    end
  end
    
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :slug, :title, :podcast
  # validates_uniqueness_of :title, :scope => :podcast_id
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  scope :w_lessons, includes(:lessons)
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  class << self
    def new_from_podcast_channel(normalized_channel, attribute_overrides={})
      new({
        title:                  normalized_channel.title,
        description:            normalized_channel.description,
        ref_link:               normalized_channel.homepage,
        poster_img_remote_url:  normalized_channel.poster_image,
        last_published_at:      normalized_channel.last_updated,
      }.merge(attribute_overrides), as: 'sudo')
    end
  end
  
  
  # Answers "Is this lesson part of this study?"
  def include?(lesson)
    raise ArgumentError.new('Study#include? requires a @lesson') unless lesson.is_a? Lesson
    lessons.include? lesson
  end
  
  # Determins if a lesson SHOULD part of this study
  # => false if lessons.empty?
  def should_include?(lesson)
    raise ArgumentError.new('Study#include? requires a @lesson') unless lesson.is_a? Lesson
    lessons.last.try :belongs_with?, lesson
  end
  
  # Single lesson study
  def stand_alone?
    lessons.size == 1 #lessons_count
  end
  
  # Replace original http://apidock.com/rails/ActiveRecord/Persistence/touch
  def touch(name=nil)
    self.lessons_count     = lessons.length
    self.last_published_at = lessons.map(&:published_at).max
    self.updated_at        = Time.now
    self.save!
  end
  
  def organization
    # future association
  end

  def tags
    # future association
  end
end
