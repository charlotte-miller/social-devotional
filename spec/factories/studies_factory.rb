# == Schema Information
#
# Table name: studies
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  podcast_id    :integer          not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#



FactoryGirl.define do
  factory :study do
    podcast
    sequence( :slug ) {|n| "matthew-study#{n}"}
    title "Matthew Study - Chapter by Chapter"
    description "We work through book of Matthew chapter by chapter using the inductive method"
    ref_link "http://link.com/salt-and-light"
    video_url "http://link.com/salt-and-light.mp4"
  end
end
