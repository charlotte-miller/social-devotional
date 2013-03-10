# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  series_id   :integer          not null
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
  attr_accessible :audio_url, :backlink, :description, :position, :series, :title, :video_url
  acts_as_list scope: :series  
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :series, counter_cache:true, touch:true
  has_many :questions, as: 'source'
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  # validates_uniqueness_of :position, :scope => :series_id
  validates_presence_of :series, :title
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # default_scope order: 'position ASC'
  scope :for_series, lambda {|series_id| where({ series_id: series_id }) }
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
end
