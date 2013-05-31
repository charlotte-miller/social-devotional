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
#  machine_sorted     :boolean          default(FALSE)
#  published_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Lesson do
  it { should belong_to( :study )}
  it { should have_many( :questions )}
  it { should delegate_method(:study_title).to(:study).as(:title) }
  
  it "builds from factory", internal:true do
    lambda { create(:lesson) }.should_not raise_error
  end
  
  it "touches the associated Study on update", internal:true do
    study = create(:study_w_lesson)
    study.should_receive(:touch).once
    study.lessons.first.save!
  end
    
  describe '[scopes]' do
    describe 'for_study(:study_id)' do
      pending
    end
  end
    
  describe '#similar_lesson?' do
    it "matches lessons by similar title" do
      matching_title_pairs = [
        ['Mark Part 1', 'Mark Part 2'],
        ['Mark [Part 1]', 'Mark [Part 2]'],
        ['Mark (Part 1)', 'Mark (Part 2)'],
        ['Mark Part I', 'Mark Part II']
      ].each do |title_pair|
        part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
        (part_1.similar_lesson? part_2).should be_true
      end
      
      non_matching_title_pairs = [
        ['Mark Part 1', 'Moses Part 1']
      ].each do |title_pair|
        part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
        (part_1.similar_lesson? part_2).should be_false
      end
    end
  end
end
