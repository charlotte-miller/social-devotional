# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  state            :string(50)       not null
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  is_public        :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Group < ActiveRecord::Base  
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :desription, :meeting_id, :name, :is_public  
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_one  :current_meeting,    :class_name => "meeting",  :conditions => {state: 'current'}
  has_many :meetings,           :dependent => :destroy
  has_many :group_memberships,  :dependent => :destroy
  has_many :members,            :through => :group_memberships
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :name, :desription
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  scope :is_public, where(is_public: true)
  
  
  # ---------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------
  # after_save :create_first_meeting
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
end
