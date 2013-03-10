# == Schema Information
#
# Table name: block_requests
#
#  id            :integer          not null, primary key
#  admin_user_id :integer
#  user_id       :integer          not null
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class BlockRequest < ActiveRecord::Base
  attr_accessible :source, :user_id
  
  belongs_to :requester, :class_name  => "user",       :foreign_key => "user_id"
  belongs_to :approver,  :class_name  => "admin_user", :foreign_key => "admin_id"
  belongs_to :source,    :polymorphic =>  true
  # has_one  :author,    :class_name => "user", :through => :source
  
  validates_presence_of :user, :source
end
