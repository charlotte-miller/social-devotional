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
  alias_attribute :last_attended_at, :updated_at
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :group,                                                  inverse_of: :group_memberships
  belongs_to :member, :class_name => "User", foreign_key: 'user_id',  inverse_of: :group_memberships
  # belongs_to :invitation, :class_name => "Message"
  # alias_method :invitation, :request
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :group, :member
  validates_uniqueness_of :group_id, scope: :user_id
  
  
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
  # Callbacks
  # ---------------------------------------------------------------------------------
  before_validation :keep_private_groups_private

  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
private
  def keep_private_groups_private
    self.is_public &&= group.is_public
    self
  end
  
end
