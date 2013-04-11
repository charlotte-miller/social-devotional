# == Schema Information
#
# Table name: podcasts
#
#  id           :integer          not null, primary key
#  church_id    :integer          not null
#  title        :string(100)
#  url          :string(255)      not null
#  last_checked :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'active_support'
FactoryGirl.define do
  factory :podcast do  
    church
    title { "#{church.name} Sermons" }
    url { "#{church.homepage}/podcasts/audio_podcast.xml" }
    last_checked 1.day.ago
  end
end
