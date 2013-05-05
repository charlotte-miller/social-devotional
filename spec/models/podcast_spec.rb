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
  let(:podcast) { create(:podcast) }
  
  it { should belong_to :church }
  it { should have_many :studies }
  
  it "builds from factory", internal:true do
    lambda { create(:podcast) }.should_not raise_error
  end
  
  describe '.refresh( podcasts )' do
    before(:each) do
      @podcasts = 2.times.map { create(:podcast, last_updated: Time.parse('Mon, 25 Mar 2013')) }
      @podcast  = Podcast.first
      @runner   = stub(run!:true)
    end
    
    it "updates all by default" do
      Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Podcast.refresh()
    end
    
    it "accetps an array of @podcasts" do
      Podcast::Collector.should_receive( :new ).with(@podcasts).and_return(@runner)
      Podcast.refresh(@podcasts)
    end
    
    it "accetps a single @podcast" do
      Podcast::Collector.should_receive( :new ).with([@podcast]).and_return(@runner)
      Podcast.refresh(@podcast)
    end
    
    describe '&on_complete' do
      before(:each) do
        @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))      
        stub_request(:get, %r{/podcasts/audio_podcast.xml$}).to_return( :body => @podcast_xml, :status => 200 )
      end
    
      it "updates each podcast" do
        @podcasts.each {|podcast| podcast.should_receive(:update_channel).once }
        Podcast.refresh
      end
      
      it "skips up-to-date podcasts" do
        out_of_date = Podcast.first
        up_to_date  = create(:podcast, last_updated: Time.parse('Wed, 27 Mar 2013'))
        
        out_of_date.should_receive(:update_channel)
        up_to_date.should_not_receive(:update_channel)
        Podcast.refresh
      end
    end
    
  end
  
  describe '#update_channel( normalized_channel )' do
    let(:channel_obj) { Podcast::Normalized::Channel.new(File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))) }
    
    it "creates a lesson from a podcast item" do
      pending
    end
    
    it "skips existing podcast items" do
      pending
    end
    

  end

end
