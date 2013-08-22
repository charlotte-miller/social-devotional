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
#  duration           :integer
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
    
  describe '.new_from_podcast_item(podcast_item)' do
    before(:all) { @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) }
    let!(:channel) { Podcast::Normalize::Channel.new(@podcast_xml) }
    subject { Lesson.new_from_podcast_item(channel.items.first) }
    
    it "builds a lesson from a podcast_item" do
      should be_a Lesson
      should be_valid
    end
    
    it "skips an existing lesson" do
      pending
    end
  end
  
  describe '#belongs_with?( other_lesson )' do
    subject { build_stubbed(:lesson) }
    let(:other_lesson) { build_stubbed(:lesson) }
    before(:each) do
      Lesson::SimilarityHeuristic::STRATEGIES.each {|strategy| strategy.any_instance.stub(matches?:false) } #all stragegies 'off'
    end
    
    it "returns TRUE if any of the Lesson::SimilarityHeuristic#matches?" do
      Lesson::SimilarityHeuristic::STRATEGIES.last.any_instance.stub(matches?:true)
      subject.belongs_with?( other_lesson ).should be_true
    end
    
    it "returns FALSE if NONE of the Lesson::SimilarityHeuristic#matches?" do
      subject.belongs_with?( other_lesson ).should be_false
    end
  end
end
