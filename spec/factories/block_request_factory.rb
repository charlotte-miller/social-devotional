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



FactoryGirl.define do
  factory :block_request do
    requester
    approver 
    source { FactoryGirl.create :question }
  end
  
  factory :question_block_request, :parent => :block_request do
    source { FactoryGirl.create :question }
  end
  
  factory :comment_block_request, :parent => :block_request do
    source { FactoryGirl.create :comment }
  end
end
