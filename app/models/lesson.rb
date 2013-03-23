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
  attr_accessible :audio_url, :backlink, :description, :position, :study, :study_id, :title, :video_url
  acts_as_list scope: :study 
  # alias_method :position, :to_param   #used by url helpers as :id
  
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
  # validates_uniqueness_of :position, :scope => :study_id
  validates_presence_of :study, :title
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_study, lambda {|study_id| where({ study_id: study_id }) }
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def study_title
    @study_title ||= study.select(:title).title
  end
  
private
  
  def searchable_title target
    target.downcase.gsub(/^(an?|the|for|by)\b/, '')
  end
  
  
end
