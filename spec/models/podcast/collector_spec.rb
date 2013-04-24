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
    
    it "requires an array of @podcasts" do
      lambda { Podcast::Collector.new(@podcast)         }.should raise_error(ArgumentError)
      lambda { Podcast::Collector.new(['not podcast'])  }.should raise_error(ArgumentError)
      lambda { Podcast::Collector.new([@podcast])       }.should_not raise_error
    end
  end
  
  describe '#run!' do
    before(:each) do
      @podcasts    = 2.times.map { p = create(:podcast) }
      @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))      
      stub_request(:get, %r{/podcasts/audio_podcast.xml$}).to_return( :body => @podcast_xml, :status => 200 )
    end
      
    it "calls &on_complete for each @podcast" do
      @podcasts.each {|p| p.stub(:foo)}
      @podcasts.each {|podcast| podcast.should_receive(:foo).once.with(@podcast_xml) }
      collector = Podcast::Collector.new(@podcasts) {|podcast_obj, podcast_xml| podcast_obj.foo(podcast_xml) }
      collector.run!
    end
  end
  
end