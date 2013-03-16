# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  is_public  :boolean          default(TRUE)
#  role_level :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupMembership < ActiveRecord::Base

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :group_id, :user_id, :is_public
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :group# ,                          inverse_of: 'group_memberships'
  belongs_to :member, :class_name => "user"# ,  inverse_of: 'group_memberships'
  # belongs_to :invitation, :class_name => "Message"
  # alias_method :invitation, :request
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :group, :member
  
  
  # ---------------------------------------------------------------------------------
  # StateMachine
  # ---------------------------------------------------------------------------------
  state_machine :initial => :pending do
    state :pending do
      def request_sent?  ;true;  end
    end
  end
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  scope :is_public, where(is_public: true)
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  
end
