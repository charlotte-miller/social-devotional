require 'spec_helper'

describe Podcast::Collector do
    
  describe '.new' do
    before(:each) do
      @podcasts = 2.times.map { create(:podcast) }
      @podcast  = Podcast.first
    end
    
    it "queues requests for the collection of Podcasts" do
      q = Podcast::Collector.new([@podcast]).queue
      q.length.should be(1)
      q.each do |item| 
        item.should be_an_instance_of Typhoeus::Request
        item.base_url.should == @podcast.url
      end
    end
    
    it "defaults to Podcast.all" do
      q = Podcast::Collector.new.queue
      q.length.should be(2)
    end
    
    it "accetps a single podcast" do
      q = Podcast::Collector.new(@podcast).queue
      q.length.should be(1)
    end
  end
  
  describe '#run!' do
    before(:each) do
      @podcast     = create(:podcast)
      @collector   = Podcast::Collector.new(@podcast)
      @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))      
      stub_request(:get, %r{/podcasts/audio_podcast.xml$}).to_return( :body => @podcast_xml, :status => 200 )
    end
    
    it "should 'parse' each podcast", internal:true do
      Podcast::Parser.should_receive(:new).with(@podcast_xml).and_return(stub(:run! => true)) 
      @collector.run!
    end
    
    it "should create studies / lessons" do
      false.should be_true
    end
  end
  
end