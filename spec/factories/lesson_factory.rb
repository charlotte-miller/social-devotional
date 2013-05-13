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
#  audio_file_name    :string(255)
#  audio_content_type :string(255)
#  audio_file_size    :integer
#  audio_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#



FactoryGirl.define do
  factory :lesson do
    before(:create, :stub) do
      Lesson.any_instance.stub({ save_attached_files: true }) if Rails.env.test?
    end
    
    study
    # position 1
    title "What it means to be Salt"
    description "We are called to be salt and light.  But if salt looses it's saltiness it is worthless."
    backlink "http://link.com/salt-and-light"
    video File.new(Rails.root.join('spec/files', 'video.m4v'), 'r')
    audio File.new(Rails.root.join('spec/files', 'audio.m4a'), 'r')
  end
end
