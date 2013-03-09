# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  lesson_id  :integer          not null
#  state      :string(50)       not null
#  date_of    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



FactoryGirl.define do
  factory :meeting, aliases: [:current_meeting] do
    group
    lesson
    state   'current'
    date_of { Time.now + 1.week }
  end
end
