# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  series_id   :integer          not null
#  position    :integer          default(0)
#  title       :string(255)      not null
#  description :text
#  backlink    :string(255)
#  video_url   :string(255)
#  audio_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#



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
