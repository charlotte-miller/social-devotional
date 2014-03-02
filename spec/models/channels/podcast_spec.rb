# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  church_id       :integer          not null
#  title           :string(100)      not null
#  build_options   :text
#  last_checked_at :datetime
#  last_updated_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Channels::Podcast do
  before(:each) do
    stub_request(:get, /feedproxy\.google\.com.*\.mp3$/  ).to_return( :body => audio_file, :status => 200 )
    stub_request(:get, /.*\.(png|jpg|jpeg|gif)/ ).to_return(:status => 200, :body => img_file, :headers => {})
    stub_request(:put, /.*/)
  end
  subject { create(:podcast) }

  it { should belong_to :church }
  it { should have_many :studies }
  it { should delegate_method(:name).to(:church).with_prefix }
  it { should delegate_method(:homepage).to(:church).with_prefix }

  it "builds from factory", :internal do
    lambda { create(:podcast) }.should_not raise_error
  end

  describe '#studies.most_recent( n=nil )' do
    before(:each) do
      @podcast = create(:podcast_with_n_studies, n:2 )
      @study1, @study2 = @studies = @podcast.studies
    end
  
    it "returns the most recently published lessons" do
      @podcast.studies.most_recent.last_published_at.should be > @study1.last_published_at 
      @podcast.studies.most_recent.should eql @podcast.studies.last
    end
      
    it "returns an obj or sorted collection (depending on N)" do
      recent_1 = @podcast.studies.most_recent
      recent_n = @podcast.studies.most_recent(2)
    
      recent_1.should be_a Study
      recent_n.should be_a Array
      recent_n.should have(2).items
      recent_n[0].last_published_at < recent_n[1].last_published_at
    end
  end

  describe '.pull_updates( podcasts )' do
    before(:each) do
      @podcasts = 2.times.map { create(:podcast, last_updated_at: Time.parse('Mon, 25 Mar 2013')) }
      @podcast  = Channels::Podcast.first
      @runner   = double(run!:true)
    end
  
    it "updates all by default" do
      Channels::Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Channels::Podcast.pull_updates()
    end
  
    it "accetps an array of @podcasts" do
      Channels::Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Channels::Podcast.pull_updates(@podcasts)
    end
  
    it "accetps a single @podcast" do
      Channels::Podcast::Collector.should_receive( :new ).with([@podcast]).and_return(@runner)
      Channels::Podcast.pull_updates(@podcast)
    end
      
    describe '- after fetching the podcast XML', :internal do
      before(:each) do
        @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))      
        stub_request(:get, %r{/podcasts/audio_podcast.xml$}).to_return( :body => @podcast_xml, :status => 200 )
      end
    
      it "updates #last_checked_at" do
        inital_last_checked = @podcast.last_checked_at
        Timecop.travel(1.minute) { Channels::Podcast.pull_updates(@podcast) }
        @podcast.last_checked_at.should be > inital_last_checked
      end
  
      it "updates each podcast" do
        @podcasts.each {|podcast| podcast.should_receive(:update_channel).once }
        Channels::Podcast.pull_updates(@podcasts)
      end
    
      it "skips up-to-date podcasts" do
        out_of_date = Channels::Podcast.first
        up_to_date  = create(:podcast, last_updated_at: Time.parse('Wed, 27 Mar 2013'))
      
        out_of_date.should_receive(:update_channel)
        up_to_date.should_not_receive(:update_channel)
        Channels::Podcast.pull_updates([out_of_date, up_to_date])
      end
    end
  
  end

  describe '#update_channel( normalized_channel )' do
    let(:podcast) { create(:podcast) }
    let(:channel_obj) { Channels::Podcast::Channel.new(File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))) }
    let(:recycle_file) { Lesson.any_instance.stub(:duplicate?)  }
    subject { podcast.update_channel( channel_obj ) }
  
    it "creates a lesson from a podcast item" do
      Lesson.count.should be 0
      subject # execute
      Lesson.count.should be > 0
    end
  
    it "skips existing podcast items" do
      inital_lessons_count = subject.studies.sum(&:lessons_count)
      subject.update_channel(channel_obj) # same file
      subject.studies.sum(&:lessons_count).should be inital_lessons_count
    end
  
    it "groups similar lessons in the same study" do
      # pp subject.studies.map(&:lessons).map {|l| l.map(&:title)}
      subject.studies.map(&:lessons_count).any? {|count| count > 1}.should be_true
    end
  
    it "updates #last_updated" do
      inital_last_updated = subject.last_updated
      Timecop.travel(1.minute) { recycle_file; subject.update_channel(channel_obj) }
      subject.last_updated.should be > inital_last_updated
    end
  end

end
