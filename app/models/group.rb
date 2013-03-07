# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  meeting_id       :integer
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  public           :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Group < ActiveRecord::Base  
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :desription, :meeting_id, :name, :public  
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_one :current_meeting, :class_name => "Meeting", :foreign_key => "meeting_id"  
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :name, :desription
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  scope :public, where(public: true)
  
  
  # ---------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------
  # after_save :create_first_meeting
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
end
