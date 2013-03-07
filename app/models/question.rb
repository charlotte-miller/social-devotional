# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  source_id     :integer
#  source_type   :string(255)
#  text          :text
#  answers_count :integer
#  blocked_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Question < ActiveRecord::Base

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :source, :text, :answers_count  
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :source, polymorphic: true
  # belongs_to :meeting, polymorphic: true, as: 'source'
  # belongs_to :lesson,  polymorphic: true, as: 'source'  
  
  
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