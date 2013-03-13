# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  study_id    :integer          not null
#  position    :integer          default(0)
#  title       :string(255)      not null
#  description :text
#  backlink    :string(255)
#  video_url   :string(255)
#  audio_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lesson < ActiveRecord::Base
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :audio_url, :backlink, :description, :position, :studies, :title, :video_url
  acts_as_list scope: :studies 
  
  # http://sunspot.github.com/
  # searchable do
  #   string( :title  )       { searchable_title title        }
  #   string( :studies_title ) { searchable_title studies.title }
  #   text    :description
  # end 
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :studies, counter_cache:true, touch:true
  has_many :questions, as: 'source'# , inverse_of: 'source'
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  # validates_uniqueness_of :position, :scope => :studies_id
  validates_presence_of :studies, :title
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_studies, lambda {|studies_id| where({ studies_id: studies_id }) }
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  
private
  
  def searchable_title target
    target.downcase.gsub(/^(an?|the|for|by)\b/, '')
  end
  
  
end
