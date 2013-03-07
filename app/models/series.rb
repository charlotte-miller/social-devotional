# == Schema Information
#
# Table name: series
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
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
  attr_accessible :description, :ref_link, :slug, :title, :video_url
  friendly_id :title, :use => :slugged
  searchable do
    text :title
    text :organization
    text :tags
  end
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_many :lessons, :order => :position, :dependent => :destroy
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :slug, :title
  
  
  
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
end
