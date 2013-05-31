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
#  lessons_count           :integer          default(0)
#  last_published_at       :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Study < ActiveRecord::Base
  extend FriendlyId
    
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :description, :ref_link, :slug, :title, :poster_img, :poster_img_remote_url, :podcast, :podcast_id
  delegate :church_name, to: :podcast
  friendly_id :title #:slug_candidates #update after v 5.0.0
  
  def slug_candidates
    [ :title, [:title, :church_name] ]
  end
  
  has_attached_file :poster_img,
    :storage => :s3,
    :bucket => AppConfig.s3.bucket,
    :s3_credentials => AppConfig.s3.credentials,
    :path => ':rails_env/:class/:attachment/:id/:updated_at-:basename.:extension'
    # :url  => AppConfig.cloudfront.url
    
  # https://github.com/thoughtbot/paperclip/wiki/Attachment-downloaded-from-a-URL
  attr_reader :poster_img_remote_url
  def poster_img_remote_url=(url_str)
    self.poster_img=URI.parse(url_str)
    @poster_img_remote_url = url_str
  end

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
  
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  scope :w_lessons, includes(:lessons)
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  def organization
    # future association
  end

  def tags
    # future association
  end
  
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
  
private

  def searchable_title str
    str.downcase.gsub(/^(an?|the|for|by)\b/, '').strip
  end
end
