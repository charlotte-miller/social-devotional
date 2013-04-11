# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  homepage   :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'active_support'
FactoryGirl.define do
  factory :church do
    name "Cornerstone Church"
    homepage {|c| "http://#{c.name.gsub(/\s/,'').underscore.dasherize}.com"}
  end
end
