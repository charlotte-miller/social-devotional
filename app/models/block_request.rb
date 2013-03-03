class BlockRequest < ActiveRecord::Base
  attr_accessible :source, :user_id
  
  belongs_to :author,   :class_name  => "User",  :foreign_key => "user_id"
  belongs_to :approver, :class_name  => "admin", :foreign_key => "admin_id"
  belongs_to :source,   :polymorphic =>  true
end
