# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  text          :text             default(""), not null
#  answers_count :integer          default(0)
#  blocked_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#



FactoryGirl.define do
  factory :question do
    ignore do
      source { FactoryGirl.create(:lesson) }
    end
    
    author
    source_id   { source.id }
    source_type { source.class.name }
    text "Why did Jonnah try to avoid Gods command to 'go to Ninevah"
  end
  
  factory :library_question, parent: 'question' do
    source { FactoryGirl.create(:lesson) }
  end
  
  factory :group_question, parent: 'question' do
    source { FactoryGirl.create(:group) }
  end
end
