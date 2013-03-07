# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  lesson_id  :integer
#  date_of    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meeting < ActiveRecord::Base
  

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :date_of, :group_id, :lesson_id  
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :group
  belongs_to :lesson  
  has_many :questions, as: 'source'
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
end
