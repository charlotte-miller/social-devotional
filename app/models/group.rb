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
  attr_accessible :desription, :name, :is_public, :state, :meets_every_days
  attr_accessible :members, :members_attributes,  as: 'leader'
  
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_one  :current_meeting,    :conditions => {state: 'current'},  :class_name => "Meeting", foreign_key: 'group_id'
  has_many :meetings,           :dependent => :destroy,             :class_name => "Meeting", foreign_key: 'group_id'
  has_many :questions,          as: 'source'
  
  has_many :members,            :through => :group_memberships, source:'member'# ,     inverse_of: 'group'  
  # has_many :leaders,            :through => :group_memberships, source: 'member', conditions: 'group_memberships.role_level > 1'
  has_many :group_memberships,  :dependent => :destroy
  accepts_nested_attributes_for :group_memberships, 
                                allow_destroy: true, 
                                reject_if: lambda { !(attributes[:members_attributes].try([], :user_id)) }
  
  
  def leaders; members.where('group_memberships.role_level > 1') ;end
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :name, :desription, :state
  
  
  
  # ---------------------------------------------------------------------------------
  # StateMachine
  # ---------------------------------------------------------------------------------
  state_machine :initial => :open do
    state :open do
      def accepting_members?  ;true;  end
    end
  end
  

  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  # scope :for_user, lambda {|user| where(user)}
  scope :is_currently, lambda {|state| {:conditions => { :state => state.to_s }} }
  scope :is_public,    where(is_public: true)
  scope :publicly_searchable, is_public.is_currently(:open)

  
  
  # ---------------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------------
  # after_save :create_first_meeting
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  
end
