# == Schema Information
#
# Table name: series
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :series do
    slug "MyString"
    title "MyString"
    description "MyString"
    ref_link "MyString"
    video_url "MyString"
  end
end
