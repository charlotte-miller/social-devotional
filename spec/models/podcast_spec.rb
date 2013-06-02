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

require 'spec_helper'

describe Podcast do
  subject { create(:podcast) }
  
  it { should belong_to :church }
  it { should have_many :studies }
  it { should delegate_method(:church_name).to(:church).as(:name) }
  it { should delegate_method(:church_homepage).to(:church).as(:homepage) }
  
  it "builds from factory", internal:true do
    lambda { create(:podcast) }.should_not raise_error
  end
  
  describe '#studies.most_recent( n=nil )' do
    before(:each) do
      @podcast = create(:podcast_with_n_studies, n:2 )
      @study1, @study2 = @studies = @podcast.studies
    end
    
    it "returns the most recently published lessons" do
      @podcast.studies.most_recent.last_published_at.should be > @study1.last_published_at 
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
      @podcasts = 2.times.map { create(:podcast, last_updated: Time.parse('Mon, 25 Mar 2013')) }
      @podcast  = Podcast.first
      @runner   = stub(run!:true)
    end
    
    it "updates all by default" do
      Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Podcast.pull_updates()
    end
    
    it "accetps an array of @podcasts" do
      Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Podcast.pull_updates(@podcasts)
    end
    
    it "accetps a single @podcast" do
      Podcast::Collector.should_receive( :new ).with([@podcast]).and_return(@runner)
      Podcast.pull_updates(@podcast)
    end
        
    describe '- after fetching the podcast XML', internal:true do
      before(:each) do
        @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))      
        stub_request(:get, %r{/podcasts/audio_podcast.xml$}).to_return( :body => @podcast_xml, :status => 200 )
      end
      
      it "updates #last_checked" do
        inital_last_checked = @podcast.last_checked
        Timecop.travel(1.minute) { Podcast.pull_updates(@podcast) }
        @podcast.last_checked.should be > inital_last_checked
      end
    
      it "updates each podcast" do
        @podcasts.each {|podcast| podcast.should_receive(:update_channel).once }
        Podcast.pull_updates(@podcasts)
      end
      
      it "skips up-to-date podcasts" do
        out_of_date = Podcast.first
        up_to_date  = create(:podcast, last_updated: Time.parse('Wed, 27 Mar 2013'))
        
        out_of_date.should_receive(:update_channel)
        up_to_date.should_not_receive(:update_channel)
        Podcast.pull_updates([out_of_date, up_to_date])
      end
    end
    
  end
  
  describe '#update_channel( normalized_channel )' do
    let(:channel_obj) { Podcast::Normalize::Channel.new(File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))) }
    
    it "creates a lesson from a podcast item" do
      pending
    end
    
    it "skips existing podcast items" do
      pending
    end
    
    it "adds similar lessons to the same study" do
      pending
    end
    
    it "updates #last_updated" do
      inital_last_updated = subject.last_updated
      Timecop.travel(1.minute) { subject.update_channel(channel_obj) }
      subject.last_updated.should be > inital_last_updated
    end
  end

end
