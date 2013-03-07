# == Schema Information
#
# Table name: block_requests
#
#  id          :integer          not null, primary key
#  admin_id    :integer
#  user_id     :integer          not null
#  source_id   :integer          not null
#  source_type :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BlockRequest < ActiveRecord::Base
  attr_accessible :source, :user_id
  
  belongs_to :author,   :class_name  => "User",  :foreign_key => "user_id"
  belongs_to :approver, :class_name  => "admin", :foreign_key => "admin_id"
  belongs_to :source,   :polymorphic =>  true
  
  validates_presence_of :user, :source
end
