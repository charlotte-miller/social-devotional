# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :block_request do
    user
    admin
    source { FactoryGirl.create :question }
  end
end