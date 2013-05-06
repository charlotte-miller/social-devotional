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
#  audio_file_name    :string(255)
#  audio_content_type :string(255)
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Lesson < ActiveRecord::Base
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  acts_as_list scope: :study
  attr_accessible :study, :study_id, :position, :title, :description, :backlink, 
                  :audio, :video, :audio_remote_url, :video_remote_url
  
  has_attached_file :audio,
    :storage => :s3,
    :bucket => AppConfig.s3.bucket,
    :s3_credentials => AppConfig.s3.credentials,
    :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension'
    # :url  => AppConfig.cloudfront.url
    
  has_attached_file :video,
    :storage => :s3,
    :bucket => AppConfig.s3.bucket,
    :s3_credentials => AppConfig.s3.credentials,
    :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension'
    # :url  => AppConfig.cloudfront.url
  
  
  # https://github.com/thoughtbot/paperclip/wiki/Attachment-downloaded-from-a-URL
  attr_reader :audio_remote_url, :video_remote_url
  def audio_remote_url=(url_str)
    self.audio=URI.parse(url_str)
    @audio_remote_url = url_str
  end
  
  def video_remote_url=(url_str)
    self.video=URI.parse(url_str)
    @video_remote_url = url_str
  end
  
  # http://sunspot.github.com/
  # searchable do
  #   string( :title  )       { searchable_title title        }
  #   string( :study_title ) { searchable_title study.title }
  #   text    :description
  # end 
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :study, counter_cache:true, touch:true
  has_many :questions, as: 'source'# , inverse_of: 'source'
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :study, :title
  # validates_uniqueness_of :position, :scope => :study_id
  # validates_attachment_presence :audio, :video
  
  # http://stackoverflow.com/questions/3181845/validate-attachment-content-type-paperclip
  # validates_attachment_content_type :audio
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_study, lambda {|study_id| where({ study_id: study_id }) }
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  # def to_param; position ;end #used by url helpers as :id
  
  def study_title
    @study_title ||= Study.select(:title).where( id:study_id ).first.title
  end
  
private
  
  def searchable_title target
    target.downcase.gsub(/^(an?|the|for|by)\b/, '')
  end
  
  
end
