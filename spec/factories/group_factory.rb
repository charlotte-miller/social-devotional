# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  state            :string(50)       not null
#  name             :string(255)      not null
#  desription       :text             default(""), not null
#  is_public        :boolean          default(TRUE)
#  meets_every_days :integer          default(7)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#



FactoryGirl.define do
  factory :group do
    state 'open'
    name  "Bible in a Year!"
    desription "We're going to read through the Bible in one year, and discuss weekly."
    meets_every_days 7
    is_public true
  end
end
