# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  text          :text             default(""), not null
#  answers_count :integer          default(0)
#  blocked_count :integer          default(0)
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
  belongs_to :source,  polymorphic: true
  # belongs_to :meeting, :class_name => 'Meeting', :foreign_key => 'source_id'   # these only work with the propery type... probably needs to be a method
  # belongs_to :lesson,  :class_name => 'Lesson', :foreign_key => 'source_id'    # these only work with the propery type... probably needs to be a method
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :user, :source, :text
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
end
