

FactoryGirl.define do
  factory :block_request do
    user
    admin
    source { FactoryGirl.create :question }
  end
end
