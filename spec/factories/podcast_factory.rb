# == Schema Information
#
# Table name: podcasts
#
#  id           :integer          not null, primary key
#  church_id    :integer          not null
#  title        :string(100)
#  url          :string(255)      not null
#  last_checked :datetime
#  last_updated :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'active_support'
FactoryGirl.define do
  factory :podcast do  
    ignore do
      study nil
    end
    
    church
    studies { [study].compact }
    title   { "#{church.name} Sermons" }
    url     { "#{church.homepage}/podcasts/audio_podcast.xml" }
    last_updated 2.days.ago
    last_checked 1.day.ago
  end
  
  # creates a podcast w/ a single study
  factory :podcast_w_study, parent:'podcast' do |podcast|
    study {FactoryGirl.create(:study, last_published_at:Time.now, podcast:build_stubbed(:podcast) )}
    after(:create) {|podcast| podcast.reload }
  end
  
  # creates a podcast w/ 'n' number of assocaiated studies
  factory :podcast_w_studies, aliases:[:podcast_with_n_studies], parent:'podcast' do |podcast|
    ignore  { n 2 }
    studies { n.times.map { |i| FactoryGirl.create(:study, last_published_at:Time.now+i, podcast:build_stubbed(:podcast) )} }
    after(:create) {|podcast| podcast.reload }
  end
end
