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
#  video_url               :string(255)
#  poster_img_file_name    :string(255)
#  poster_img_content_type :string(255)
#  poster_img_file_size    :integer
#  poster_img_updated_at   :datetime
#  lessons_count           :integer          default(0)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Study < ActiveRecord::Base
  extend FriendlyId
    
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :description, :ref_link, :slug, :title, :video_url, :podcast, :podcast_id
  has_attached_file :poster_img #aws setup
  friendly_id :title
  # delegate :something to: :podcasts

  # http://sunspot.github.com/
  searchable do
    string(  :title)                { searchable_title title } #, boost: 2.0 
    string(  :lesson_title    )     { searchable_title lessons.select(:title).map(&:title).join(' | ') }
    text     :description
    string(  :church_name     )     { church.name       }
    integer( :church_id       )     { podcast.church_id }
    # string(  :tags          )     { tags.select(:text).map(&:text).join(' | ')}
  end
  
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_many :lessons, :order => :position, :dependent => :destroy do
    def number(n)
      raise ArgumentError if n > lessons_count
      where(position:n) 
    end
  end
  
  belongs_to :podcast#, :inverse_of => :studies
  has_one :church,     :through => :podcast
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :slug, :title, :podcast
  
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
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
  
private

  def searchable_title target
    target.downcase.gsub(/^(an?|the|for|by)\b/, '')
  end
end
