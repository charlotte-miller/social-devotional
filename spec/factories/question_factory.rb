# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  source_id     :integer
#  source_type   :string(255)
#  text          :text
#  answers_count :integer
#  blocked_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    lesson
    group
    text "Why did Jonnah try to avoid Gods command to 'go to Ninevah"
    answers_count 0
  end
end
