# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  admin_user_id :integer
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  text          :text
#  answers_count :integer          default(0)
#  blocked_count :integer          default(0)
#  stared_count  :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#



FactoryGirl.define do
  factory :question do  
    permanent_approver
    author
    source { FactoryGirl.create(:lesson) }
    text   { Faker::Lorem.sentence(rand(3..6)) }
    # answers_count 0
  end
  
  factory :library_question, parent: 'question' do
    source { FactoryGirl.create(:lesson) }
  end
  
  factory :group_question, parent: 'question' do
    source { FactoryGirl.create(:group) }
  end
end
