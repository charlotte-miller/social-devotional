# == Schema Information
#
# Table name: stars
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  source_id   :integer          not null
#  source_type :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#



FactoryGirl.define do
  factory :star do
    user
    source ""
  end
end
