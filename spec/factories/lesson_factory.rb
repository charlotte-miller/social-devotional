# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    series
    # position 1
    title "MyString"
    description "MyText"
    backlink "http://link.com"
    video_url "MyString"
    audio_url "MyString"
  end
end
