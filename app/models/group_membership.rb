class GroupMembership < ActiveRecord::Base
  attr_accessible :group_id, :user_id, :public
  
  belongs_to :group_id
  belongs_to :user_id
  
  scope :public, where(public: true)
end
