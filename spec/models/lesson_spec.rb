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

require 'spec_helper'
require 'cocaine'

describe Lesson do
  before(:each) do
    Cocaine::CommandLine.any_instance.stub(:run)
  end
  
  it { should belong_to( :study )}
  it { should have_many( :questions )}
  it { should delegate_method(:title).to(:study).with_prefix }
  
  it "builds from factory", internal:true do
    lambda { create(:lesson) }.should_not raise_error
  end
  
  it "touches the associated Study on update", internal:true do
    study = create(:study_w_lesson)
    study.should_receive(:touch).once
    study.lessons.first.save!
  end
    
  describe '[scopes]'do
    describe 'for_study(:study_id)' do
      it "adds WHERE(study_id=n)" do
        Lesson.for_study(1).to_sql.should match /WHERE `lessons`.`study_id` = 1/
      end
    end
  end
    
  describe '.new_from_podcast_item(podcast_item)' do
    before(:each) do
      @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))
      stub_request(:get, /feedproxy\.google\.com.*\.mp3$/  ).to_return( :body => audio_file, :status => 200 )
    end
    
    before(:all) {  }
    let!(:channel) { Podcast::Normalize::Channel.new(@podcast_xml) }
    subject { Lesson.new_from_podcast_item(channel.items.first) }
    
    it "builds a lesson from a podcast_item" do
      should be_a Lesson
      subject.study = Study.new
      should be_valid
    end
    
    it "requires a study sepratly" do
      subject.valid?
      subject.errors.messages.should eq( :study => ["can't be blank"] )
    end
  end
  
  describe '#belongs_with?( other_lesson )' do
    subject { build_stubbed(:lesson) }
    let(:other_lesson) { build_stubbed(:lesson) }
    before(:each) do
      Lesson::SimilarityHeuristic::Base::STRATEGIES.each {|strategy| strategy.any_instance.stub(matches?:false) } #all stragegies 'off'
    end
    
    it "returns TRUE if any of the Lesson::SimilarityHeuristic#matches?" do
      Lesson::SimilarityHeuristic::Base::STRATEGIES.last.any_instance.stub(matches?:true)
      subject.belongs_with?( other_lesson ).should be_true
    end
    
    it "returns FALSE if NONE of the Lesson::SimilarityHeuristic#matches?" do
      subject.belongs_with?( other_lesson ).should be_false
    end
  end
  
  describe '#duplicate?' do
    it "matches on backlink" do
      a, b = 2.times.map { build(:lesson, backlink:'foo') }
      a.save
      b.should be_duplicate
    end
  end
end
