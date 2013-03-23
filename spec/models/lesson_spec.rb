# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  study_id    :integer          not null
#  position    :integer          default(0)
#  title       :string(255)      not null
#  description :text
#  backlink    :string(255)
#  video_url   :string(255)
#  audio_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Lesson do
  it { should belong_to( :study )}
  it { should have_many( :questions )}
  
  it "builds from factory" do
    lambda { create(:lesson) }.should_not raise_error
  end
  
  describe 'scopes' do
    describe 'for_study(:study_id)' do
      pending
    end
  end
end
