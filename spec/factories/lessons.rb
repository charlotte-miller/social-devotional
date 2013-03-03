# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    series_id 1
    position 1
    title "MyString"
    description "MyText"
    backlink ""
    video_url "MyString"
    audio_url "MyString"
  end
end
