

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
