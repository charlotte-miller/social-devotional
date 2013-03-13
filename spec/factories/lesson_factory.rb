# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  study_id    :integer          not null
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
    study
    # position 1
    title "What it means to be Salt"
    description "We are called to be salt and light.  But if salt looses it's saltiness it is worthless."
    backlink "http://link.com/salt-and-light"
    video_url "http://link.com/salt-and-light.mp4"
    audio_url "http://link.com/salt-and-light.mp3"
  end
end
