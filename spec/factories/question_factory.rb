# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    lesson
    group
    text "Why did Jonnah try to avoid Gods command to 'go to Ninevah"
    answers_count 0
  end
end
