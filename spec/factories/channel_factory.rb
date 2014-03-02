# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  church_id       :integer          not null
#  title           :string(100)      not null
#  build_options   :text
#  last_checked_at :datetime
#  last_updated_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    type 'Channels::Podcast'
    church
    title "MyString"
    build_options Hash.new
    last_checked_at Time.now - 1.day
    last_updated_at Time.now - 1.day
  end
end
