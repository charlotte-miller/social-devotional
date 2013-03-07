# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  meeting_id       :integer
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  public           :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    series
    name "MyString"
    desription "MyText"
  end
end
