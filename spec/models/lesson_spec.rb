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

require 'spec_helper'

describe Lesson do
  it { should belong_to( :study )}
  it { should have_many( :questions )}
  
  it "builds from factory", internal:true do
    lambda { create(:lesson) }.should_not raise_error
  end
  
  describe 'scopes' do
    describe 'for_study(:study_id)' do
      pending
    end
  end
end
