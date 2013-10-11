# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  study_id           :integer          not null
#  position           :integer          default(0)
#  title              :string(255)      not null
#  description        :text
#  backlink           :string(255)
#  video_file_name    :string(255)
#  video_content_type :string(255)
#  video_file_size    :integer
#  video_updated_at   :datetime
#  video_original_url :string(255)
#  audio_file_name    :string(255)
#  audio_content_type :string(255)
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  audio_original_url :string(255)
#  machine_sorted     :boolean          default(FALSE)
#  duration           :integer
#  published_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#



FactoryGirl.define do
  factory :lesson do
    before(:create, :stub) { AWS.stub! if Rails.env.test? }
    
    study
    # position 1
    title       { Faker::Lorem.sentence(rand(3..6))  }
    description { Faker::Lorem.paragraph(rand(2..5)) }
    backlink "http://link.com/salt-and-light"
    video File.new(Rails.root.join('spec/files', 'video.m4v'), 'r')
    audio File.new(Rails.root.join('spec/files', 'audio.m4a'), 'r')
    video_original_url 'http://example.com/video.m4v'
    audio_original_url 'http://example.com/audio.m4a'
    published_at Time.now
  end
end
