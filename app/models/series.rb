# == Schema Information
#
# Table name: series
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  podcast_id    :integer          not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Series < ActiveRecord::Base
  extend FriendlyId
    
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :description, :ref_link, :slug, :title, :video_url, :podcast, :podcast_id
  friendly_id :title

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
  has_many :lessons, :order => :position, :dependent => :destroy
  belongs_to :podcast
  has_one :church, through: 'podcast'
  
  
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
