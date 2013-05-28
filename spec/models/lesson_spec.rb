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
  
  describe '- after_save' do
    let!(:study)           { create(:study_w_lesson).reload }
    let(:existing_lesson)  { study.lessons.first }
    let(:add_lesson)       { create(:lesson, study:study, published_at:Time.now+1.day )}
    
    it "'touches' the associated Study" do
      inital_timestamp = study.updated_at
      Timecop.travel(1.second) { add_lesson }
      study.updated_at.should be > inital_timestamp
    end
    
    describe "if it's the last lesson" do
      it "updates the associated Study#last_published_at" do
        study.last_published_at.should     eql existing_lesson.published_at # initial published_at assigned
        add_lesson.published_at.should_not eql existing_lesson.published_at # create a lesson w/ a different published_at
        study.last_published_at.should     eql add_lesson.published_at      # check that it's assigned correctly
      end
      
    end
    
    describe "when it's NOT the last lesson" do
      it "does NOT update the associated Study#last_published_at" do
        add_lesson
        existing_lesson.touch 
        study.last_published_at.should eql add_lesson.published_at
        # wierd reload issue
      end
    end
  end
  
  describe '- scopes' do
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
